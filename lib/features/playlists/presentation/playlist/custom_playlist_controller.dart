import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/custom_playlist_repository.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/domain/state/my_playlists_state.dart';

import 'playlist_controller.dart';

class CustomPlaylistNotifier
    extends FamilyNotifier<PlaylistDetailsState, String> {
  late final CustomPlaylistRepository _repository;

  @override
  PlaylistDetailsState build(String arg) {
    _repository = ref.watch(customPlaylistRepositoryProvider);

    // Глобальный myPlaylistsState — единственный владелец состава плейлиста.
    // Слушаем состав именно нашего плейлиста; когда он меняется снаружи
    // (например, "Add to playlist" с другого экрана) — пересобираем треки.
    ref.listen(
      myPlaylistsStateProvider.select(
        (s) =>
            s.playlists.where((p) => p.id == arg).firstOrNull?.trackDocIds ??
            const <String>[],
      ),
      (_, next) => _onCompositionChanged(next),
    );

    return const PlaylistDetailsState.loading();
  }

  /// Реагирует на изменение состава плейлиста в глобальном стейте.
  /// Защита от самоподрыва: если новый состав совпадает с уже
  /// отрисованными локально треками (наша же правка вернулась через
  /// глобальный) — ничего не делаем.
  Future<void> _onCompositionChanged(List<String> docIds) async {
    final current = state;
    if (current is! PlaylistDetailsData) return;

    final localIds = current.tracks.map((t) => t.id).toSet();
    if (localIds.length == docIds.length && localIds.containsAll(docIds)) {
      return;
    }
    await _reconcileFromGlobal();
  }

  /// Перезапрашивает полные треки и берёт свежий Playlist (с верным
  /// trackCount) из глобального — чтобы список и счётчик на экране
  /// были согласованы.
  Future<void> _reconcileFromGlobal() async {
    final updated = ref
        .read(myPlaylistsStateProvider)
        .playlists
        .where((p) => p.id == arg)
        .firstOrNull;
    if (updated == null) return;

    try {
      final tracks = await _repository.getCustomPlaylistTracks(arg);
      state = PlaylistDetailsState.data(playlist: updated, tracks: tracks);
    } catch (_) {
      // Фоновое обновление — при ошибке оставляем текущий снимок.
    }
  }

  Future<void> init(Playlist? initialPlaylist) async {
    if (state is PlaylistDetailsData) return;

    if (initialPlaylist != null) {
      state = PlaylistDetailsState.data(playlist: initialPlaylist, tracks: []);
      await loadTracks(initialPlaylist);
    } else {
      await loadFull();
    }
  }

  Future<void> loadFull() async {
    state = const PlaylistDetailsState.loading();
    try {
      final myPlaylists = ref.read(myPlaylistsStateProvider).playlists;
      Playlist? playlist = myPlaylists.where((p) => p.id == arg).firstOrNull;

      if (playlist == null) {
        await ref.read(myPlaylistsStateProvider.notifier).loadFavorites();
        playlist = ref
            .read(myPlaylistsStateProvider)
            .playlists
            .where((p) => p.id == arg)
            .firstOrNull;
      }

      if (playlist == null) throw Exception('Playlist not found');

      final tracks = await _repository.getCustomPlaylistTracks(arg);
      state = PlaylistDetailsState.data(playlist: playlist, tracks: tracks);
    } catch (e) {
      state = PlaylistDetailsState.error(message: e.toString());
    }
  }

  Future<void> loadTracks(Playlist playlist) async {
    try {
      final tracks = await _repository.getCustomPlaylistTracks(arg);
      state = PlaylistDetailsState.data(playlist: playlist, tracks: tracks);
    } catch (e) {
      state = PlaylistDetailsState.error(message: e.toString());
    }
  }

  void reorder(int from, int to) {
    final current = state;
    if (current is! PlaylistDetailsData) return;

    final tracks = [...current.tracks];
    final item = tracks.removeAt(from);
    if (to > from) to -= 1;
    tracks.insert(to, item);
    state = current.copyWith(tracks: tracks);
  }

  void updateTracks(List<Track> newTracks) {
    final current = state;
    if (current is! PlaylistDetailsData) return;

    final updatedPlaylist = current.playlist.copyWith(
      trackCount: newTracks.length,
    );
    state = current.copyWith(playlist: updatedPlaylist, tracks: newTracks);
  }

  void removeTrack(String trackId) {
    final current = state;
    if (current is! PlaylistDetailsData) return;

    final tracks = current.tracks.where((t) => t.id != trackId).toList();
    final updatedPlaylist = current.playlist.copyWith(
      trackCount: tracks.length,
    );
    state = current.copyWith(playlist: updatedPlaylist, tracks: tracks);
  }

  Future<void> save() async {
    final current = state;
    if (current is! PlaylistDetailsData) return;

    final trackDocIds = current.tracks.map((t) => t.id).toList();
    // Берём авторитетный Playlist из репо: у него пересчитана обложка
    // (_firstTrackCover) и trackCount. Локально сохраняем уже загруженный
    // полный список треков, подменяя только playlist — так обновляется и
    // hero-хедер (imageUrl), и глобальный стейт (тайл в My Playlists).
    final updated = await _repository.updateCustomPlaylist(
      id: arg,
      name: current.playlist.title,
      trackDocIds: trackDocIds,
    );
    final saved = state;
    if (saved is PlaylistDetailsData) {
      state = saved.copyWith(playlist: updated);
      ref.read(myPlaylistsStateProvider.notifier).updatePlaylist(updated);
    }
  }

  Future<void> rename(String newName) async {
    final current = state;
    if (current is! PlaylistDetailsData) return;

    state = current.copyWith(
      playlist: current.playlist.copyWith(title: newName),
    );
    await save();
  }

  Future<void> addTracks(List<Track> newTracks) async {
    final current = state;
    if (current is! PlaylistDetailsData) return;

    // Дедуп: не добавляем треки, которые уже в плейлисте.
    final existingIds = current.tracks.map((t) => t.id).toSet();
    final unique = newTracks.where((t) => !existingIds.contains(t.id)).toList();
    if (unique.isEmpty) return;

    final merged = [...current.tracks, ...unique];
    state = current.copyWith(
      playlist: current.playlist.copyWith(trackCount: merged.length),
      tracks: merged,
    );
    await save();
  }

  Future<void> delete() async {
    await _repository.deleteCustomPlaylist(arg);
    ref.read(myPlaylistsStateProvider.notifier).removePlaylist(arg);
    ref.read(likeRegistryProvider.notifier).removePlaylist(arg);
  }
}

final customPlaylistControllerProvider =
    NotifierProvider.family<
      CustomPlaylistNotifier,
      PlaylistDetailsState,
      String
    >(CustomPlaylistNotifier.new);
