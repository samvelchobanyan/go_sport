import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/di/repository_providers.dart';
import '../../../../domain/entities/track.dart';
import '../../../../domain/state/featured_playlists_state.dart';

part 'playlist_controller.freezed.dart';

@freezed
sealed class PlaylistTracksState with _$PlaylistTracksState {
  const factory PlaylistTracksState.loading() = PlaylistTracksLoading;

  const factory PlaylistTracksState.data({
    required List<Track> tracks,
  }) = PlaylistTracksData;

  const factory PlaylistTracksState.error({
    required String message,
  }) = PlaylistTracksError;
}

class PlaylistController extends AutoDisposeFamilyNotifier<PlaylistTracksState, String> {
  @override
  PlaylistTracksState build(String playlistId) {
    Future.microtask(() => loadTracks());
    return const PlaylistTracksState.loading();
  }

  Future<void> loadTracks() async {
    state = const PlaylistTracksState.loading();

    try {
      final tracks = await ref.read(featuredPlaylistRepositoryProvider).getPlaylistTracks(arg);
      state = PlaylistTracksState.data(tracks: tracks);
    } catch (e) {
      state = PlaylistTracksState.error(message: e.toString());
    }
  }

  Future<void> toggleLike(String? likeId) async {
    try {
      final newLikeId = await ref.read(featuredPlaylistRepositoryProvider).toggleLike(arg, likeId);
      ref.read(featuredPlaylistsStateProvider.notifier).updateLike(arg, newLikeId);
    } catch (e) {
      // Можно добавить обработку ошибки
    }
  }
}

final playlistControllerProvider = NotifierProvider.autoDispose
    .family<PlaylistController, PlaylistTracksState, String>(
  PlaylistController.new,
);
