import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/di/repository_providers.dart';
import '../../../../domain/entities/track.dart';
import '../../../../domain/state/like_registry.dart';

part 'album_controller.freezed.dart';

@freezed
sealed class AlbumTracksState with _$AlbumTracksState {
  const factory AlbumTracksState.loading() = _AlbumTracksLoading;

  const factory AlbumTracksState.data({
    required List<Track> tracks,
  }) = _AlbumTracksData;

  const factory AlbumTracksState.error({
    required String message,
  }) = _AlbumTracksError;
}

class AlbumController extends AutoDisposeFamilyNotifier<AlbumTracksState, String> {
  @override
  AlbumTracksState build(String albumId) {
    ref.listen(
      likeRegistryProvider.select((s) => s.trackLikes),
      (_, next) {
        final currentTracks = state.mapOrNull(data: (d) => d.tracks);
        if (currentTracks == null) return;
        final updated = currentTracks.withLikes(next);
        if (!identical(updated, currentTracks)) {
          state = AlbumTracksState.data(tracks: updated);
        }
      },
    );
    Future.microtask(() => loadTracks());
    return const AlbumTracksState.loading();
  }

  Future<void> loadTracks() async {
    state = const AlbumTracksState.loading();

    try {
      final tracks = await ref.read(albumsRepositoryProvider).getAlbumTracks(arg);
      state = AlbumTracksState.data(tracks: tracks);
    } catch (e) {
      state = AlbumTracksState.error(message: e.toString());
    }
  }

  Future<String?> toggleLike(String albumId, [String? likeId]) async {
    return await ref.read(albumsRepositoryProvider).toggleLike(albumId, likeId);
  }
}

final albumControllerProvider = NotifierProvider.autoDispose
    .family<AlbumController, AlbumTracksState, String>(
  AlbumController.new,
);
