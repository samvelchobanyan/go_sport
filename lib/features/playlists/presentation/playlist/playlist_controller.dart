import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/di/repository_providers.dart';
import '../../../../domain/entities/playlist.dart';
import '../../../../domain/entities/track.dart';
import '../../../../domain/state/featured_playlists_state.dart';

part 'playlist_controller.freezed.dart';

@freezed
sealed class PlaylistDetailsState with _$PlaylistDetailsState {
  const factory PlaylistDetailsState.loading() = PlaylistDetailsLoading;

  const factory PlaylistDetailsState.data({
    required Playlist playlist,
    required List<Track> tracks,
  }) = PlaylistDetailsData;

  const factory PlaylistDetailsState.error({
    required String message,
  }) = PlaylistDetailsError;
}

class PlaylistController extends AutoDisposeFamilyNotifier<PlaylistDetailsState, String> {
  @override
  PlaylistDetailsState build(String playlistId) {
    return const PlaylistDetailsState.loading();
  }

  Future<void> init(Playlist? initialPlaylist) async {
    // Prevent re-initialization if already loaded (e.g. during rebuilds)
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
      final playlistsState = ref.read(featuredPlaylistsStateProvider);
      Playlist? playlist = playlistsState.getPlaylist(arg);
      
      if (playlist == null) {
        await ref.read(featuredPlaylistsStateProvider.notifier).loadPlaylists();
        playlist = ref.read(featuredPlaylistsStateProvider).getPlaylist(arg);
      }
      
      if (playlist == null) throw Exception('Playlist not found');
      
      final tracks = await ref.read(featuredPlaylistRepositoryProvider).getPlaylistTracks(arg);
      state = PlaylistDetailsState.data(playlist: playlist, tracks: tracks);
    } catch (e) {
      state = PlaylistDetailsState.error(message: e.toString());
    }
  }

  Future<void> loadTracks(Playlist playlist) async {
    try {
      final tracks = await ref.read(featuredPlaylistRepositoryProvider).getPlaylistTracks(arg);
      state = PlaylistDetailsState.data(playlist: playlist, tracks: tracks);
    } catch (e) {
      state = PlaylistDetailsState.error(message: e.toString());
    }
  }

  Future<void> toggleLike(String? likeId) async {
    final currentState = state;
    if (currentState is! PlaylistDetailsData) return;

    try {
      final newLikeId = await ref.read(featuredPlaylistRepositoryProvider).toggleLike(arg, likeId);
      
      // Update local state instantly so UI reacts
      final updatedPlaylist = currentState.playlist.copyWith(
        isLiked: newLikeId != null,
        likeId: newLikeId,
      );
      state = PlaylistDetailsState.data(playlist: updatedPlaylist, tracks: currentState.tracks);
      
      // Sync global state
      ref.read(featuredPlaylistsStateProvider.notifier).updateLike(arg, newLikeId);
    } catch (e) {
      // Error handling can be added here
    }
  }
}

final playlistControllerProvider = NotifierProvider.autoDispose
    .family<PlaylistController, PlaylistDetailsState, String>(
  PlaylistController.new,
);
