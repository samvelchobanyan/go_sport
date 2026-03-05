import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/featured_playlists_state.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

import 'playlist_controller.dart';
import 'widgets/playlist_hero.dart';
import 'widgets/playlist_screen_skeleton.dart';
import '../../../shared_widgets/track_tile.dart';

class PlaylistScreen extends ConsumerWidget {
  final String playlistId;

  const PlaylistScreen({
    super.key,
    required this.playlistId,
  });

  void _onTrackTap(WidgetRef ref, List<Track> tracks, int index, String playlistTitle, String playlistImageUrl) {
    ref.read(playerStateProvider.notifier).playQueue(
          tracks,
          source: QueueSource.playlist(
            id: playlistId,
            title: playlistTitle,
            imageUrl: playlistImageUrl,
          ),
          startIndex: index,
        );
  }

  void _onTrackMenuTap(int index) {
    // TODO: Show track menu
    debugPrint('Track menu tapped at index: $index');
  }

  void _onPlayTap(WidgetRef ref, List<Track> tracks, String playlistTitle, String playlistImageUrl) {
    if (tracks.isEmpty) return;

    ref.read(playerStateProvider.notifier).playQueue(
          tracks,
          source: QueueSource.playlist(
            id: playlistId,
            title: playlistTitle,
            imageUrl: playlistImageUrl,
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsState = ref.watch(featuredPlaylistsStateProvider);
    final playlist = playlistsState.getPlaylist(playlistId);
    final tracksState = ref.watch(playlistControllerProvider(playlistId));

    if (playlist == null) {
      return Scaffold(
        backgroundColor: DSColors.white,
        appBar: AppBar(
          backgroundColor: DSColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DSColors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(
          child: Text('Playlist not found'),
        ),
      );
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: DSColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: expandedHeight,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: DSColors.black.withOpacity(0.9),
            leading: IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: DSColors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: DSColors.white, size: 20),
              ),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: DSColors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: DSColors.white, size: 20),
                ),
                onPressed: () {
                  // TODO: Share playlist
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: PlaylistHero(
                playlist: playlist,
                onLikeTap: () => ref.read(playlistControllerProvider(playlistId).notifier).toggleLike(),
                onPlayTap: () {
                  final tracksValue = tracksState.mapOrNull(
                    data: (data) => data.tracks,
                  );
                  if (tracksValue != null) {
                    _onPlayTap(ref, tracksValue, playlist.title, playlist.imageUrl);
                  }
                },
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(24),
              child: Container(
                height: 24,
                decoration: const BoxDecoration(
                  color: DSColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
              ),
            ),
          ),
          tracksState.when(
            loading: () => const SliverFillRemaining(
              child: PlaylistScreenSkeleton(),
            ),
            error: (message) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $message', style: const TextStyle(color: DSColors.black)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.read(playlistControllerProvider(playlistId).notifier).loadTracks(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
            data: (tracks) {
              final playerState = ref.watch(playerStateProvider);
              final playingTrackId = playerState.currentTrack?.id;

              return SliverPadding(
                padding: const EdgeInsets.only(bottom: 100, top: 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final track = tracks[index];
                      final isCurrentTrack = track.id == playingTrackId;
                      final bool? trackPlayingState = isCurrentTrack
                          ? playerState.isPlaying && playerState.isRadioMode == false
                          : null;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TrackTile(
                            track: track,
                            isPlaying: trackPlayingState,
                            onTap: () => _onTrackTap(ref, tracks, index, playlist.title, playlist.imageUrl),
                            onMenuTap: () => _onTrackMenuTap(index),
                          ),
                          if (index < tracks.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: DottedDivider(),
                            ),
                        ],
                      );
                    },
                    childCount: tracks.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
