import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/custom_playlist_repository.dart';
import 'package:go_sport/features/favorites/presentation/my_playlists/my_playlists_controller.dart';

import 'playlist_controller.dart';

class CustomPlaylistNotifier
    extends FamilyNotifier<PlaylistTracksState, String> {
  late final CustomPlaylistRepository _repository;

  @override
  PlaylistTracksState build(String arg) {
    _repository = ref.watch(customPlaylistRepositoryProvider);
    Future.microtask(() => loadTracks());
    return const PlaylistTracksState.loading();
  }

  Future<void> loadTracks() async {
    state = const PlaylistTracksState.loading();
    try {
      final tracks = await _repository.getCustomPlaylistTracks(arg);
      state = PlaylistTracksState.data(tracks: tracks);
    } catch (e) {
      state = PlaylistTracksState.error(message: e.toString());
    }
  }

  void reorder(int from, int to) {
    final current = state;
    if (current is! PlaylistTracksData) return;

    final tracks = [...current.tracks];
    final item = tracks.removeAt(from);
    if (to > from) to -= 1;
    tracks.insert(to, item);
    state = current.copyWith(tracks: tracks);
  }

  void removeTrack(String trackId) {
    final current = state;
    if (current is! PlaylistTracksData) return;

    final tracks = current.tracks.where((t) => t.id != trackId).toList();
    state = current.copyWith(tracks: tracks);
  }

  Future<void> save({required String name}) async {
    final current = state;
    if (current is! PlaylistTracksData) return;

    final trackDocIds = current.tracks.map((t) => t.id).toList();
    await _repository.updateCustomPlaylist(
      id: arg,
      name: name,
      trackDocIds: trackDocIds,
    );
    ref.read(myPlaylistsStateProvider.notifier).refresh();
  }

  Future<void> rename(String newName) async {
    final current = state;
    if (current is! PlaylistTracksData) return;

    final trackDocIds = current.tracks.map((t) => t.id).toList();
    await _repository.updateCustomPlaylist(
      id: arg,
      name: newName,
      trackDocIds: trackDocIds,
    );
    ref.read(myPlaylistsStateProvider.notifier).refresh();
  }

  Future<void> addTracks(List<Track> newTracks, {required String name}) async {
    final current = state;
    if (current is! PlaylistTracksData) return;

    final merged = [...current.tracks, ...newTracks];
    state = current.copyWith(tracks: merged);

    final trackDocIds = merged.map((t) => t.id).toList();
    await _repository.updateCustomPlaylist(
      id: arg,
      name: name,
      trackDocIds: trackDocIds,
    );
    ref.read(myPlaylistsStateProvider.notifier).refresh();
  }

  Future<void> delete() async {
    await _repository.deleteCustomPlaylist(arg);
    ref.read(myPlaylistsStateProvider.notifier).refresh();
  }
}

final customPlaylistControllerProvider = NotifierProvider.family<
    CustomPlaylistNotifier, PlaylistTracksState, String>(
  CustomPlaylistNotifier.new,
);
