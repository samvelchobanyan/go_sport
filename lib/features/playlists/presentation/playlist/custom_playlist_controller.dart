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
    ref.listen(
      likeRegistryProvider.select((s) => s.trackLikes),
      (_, next) {
        final currentData = state.mapOrNull(data: (d) => d);
        if (currentData == null) return;
        final updated = currentData.tracks.withLikes(next);
        if (!identical(updated, currentData.tracks)) {
          state = currentData.copyWith(tracks: updated);
        }
      },
    );
    return const PlaylistDetailsState.loading();
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
        playlist = ref.read(myPlaylistsStateProvider).playlists.where((p) => p.id == arg).firstOrNull;
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

    final updatedPlaylist = current.playlist.copyWith(trackCount: newTracks.length);
    state = current.copyWith(playlist: updatedPlaylist, tracks: newTracks);
  }

  void removeTrack(String trackId) {
    final current = state;
    if (current is! PlaylistDetailsData) return;

    final tracks = current.tracks.where((t) => t.id != trackId).toList();
    final updatedPlaylist = current.playlist.copyWith(trackCount: tracks.length);
    state = current.copyWith(playlist: updatedPlaylist, tracks: tracks);
  }

  Future<void> save() async {
    final current = state;
    if (current is! PlaylistDetailsData) return;

    final trackDocIds = current.tracks.map((t) => t.id).toList();
    await _repository.updateCustomPlaylist(
      id: arg,
      name: current.playlist.title,
      trackDocIds: trackDocIds,
    );
    final saved = state;
    if (saved is PlaylistDetailsData) {
      ref.read(myPlaylistsStateProvider.notifier).updatePlaylist(saved.playlist);
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

    final merged = [...current.tracks, ...newTracks];
    state = current.copyWith(
      playlist: current.playlist.copyWith(trackCount: merged.length),
      tracks: merged,
    );
    await save();
  }

  Future<void> delete() async {
    await _repository.deleteCustomPlaylist(arg);
    ref.read(myPlaylistsStateProvider.notifier).removePlaylist(arg);
  }
}

final customPlaylistControllerProvider = NotifierProvider.family<
    CustomPlaylistNotifier, PlaylistDetailsState, String>(
  CustomPlaylistNotifier.new,
);
