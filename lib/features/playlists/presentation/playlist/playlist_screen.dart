import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/featured_playlists_state.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

import '../../../../domain/entities/track.dart';
import 'playlist_controller.dart';
import 'widgets/playlist_hero.dart';
import 'widgets/track_tile.dart';
import 'widgets/playlist_screen_skeleton.dart';

class PlaylistScreen extends ConsumerStatefulWidget {
  final String playlistId;

  const PlaylistScreen({
    super.key,
    required this.playlistId,
  });

  @override
  ConsumerState<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset.clamp(0, double.infinity);
    });
  }

  void _onTrackTap(List<Track> tracks, int index) {
    final playlist = ref.read(featuredPlaylistsStateProvider).getPlaylist(widget.playlistId);
    if (playlist == null) return;

    ref.read(playerStateProvider.notifier).playQueue(
      tracks,
      source: QueueSource.playlist(
        id: playlist.id,
        title: playlist.title,
        imageUrl: playlist.imageUrl,
      ),
      startIndex: index,
    );
  }

  void _onTrackMenuTap(int index) {
    // TODO: Show track menu
    debugPrint('Track menu tapped at index: $index');
  }

  void _onPlayTap(List<Track> tracks) {
    final playlist = ref.read(featuredPlaylistsStateProvider).getPlaylist(widget.playlistId);
    if (playlist == null || tracks.isEmpty) return;

    ref.read(playerStateProvider.notifier).playQueue(
      tracks,
      source: QueueSource.playlist(
        id: playlist.id,
        title: playlist.title,
        imageUrl: playlist.imageUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final playlistsState = ref.watch(featuredPlaylistsStateProvider);
    final playlist = playlistsState.getPlaylist(widget.playlistId);
    final tracksState = ref.watch(playlistControllerProvider(widget.playlistId));

    if (playlist == null) {
      return Scaffold(
        backgroundColor: DSColors.white,
        appBar: AppBar(
          backgroundColor: DSColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: DSColors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(
          child: Text('Playlist not found'),
        ),
      );
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final heroHeight = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: DSColors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: DSColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: DSColors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: DSColors.white, size: 20),
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
              child: Icon(Icons.share, color: DSColors.white, size: 20),
            ),
            onPressed: () {
              // TODO: Share playlist
            },
          ),
        ],
      ),
      body: tracksState.when(
        loading: () => const PlaylistScreenSkeleton(),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $message', style: TextStyle(color: DSColors.white)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(playlistControllerProvider(widget.playlistId).notifier).loadTracks(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (tracks) {
          final playerState = ref.watch(playerStateProvider);
          final playingTrackId = playerState.currentTrack?.id;

          return Stack(
            children: [
              // Hero background (fixed position with parallax)
              PlaylistHero(
                playlist: playlist,
                scrollOffset: _scrollOffset,
                onLikeTap: () => ref.read(playlistControllerProvider(widget.playlistId).notifier).toggleLike(),
                onPlayTap: () => _onPlayTap(tracks),
              ),

            // Scrollable content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Spacer for hero
                  SizedBox(height: heroHeight - 24),

                  // White container with tracks
                  Container(
                    constraints: BoxConstraints(
                      minHeight: screenHeight - heroHeight + 100,
                    ),
                    decoration: const BoxDecoration(
                      color: DSColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        // Tracks list
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: tracks.length,
                          separatorBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: DottedDivider(),
                          ),
                          itemBuilder: (context, index) {
                            final track = tracks[index];
                            final isPlaying = track.id == playingTrackId && playerState.isPlaying;
                            return TrackTile(
                              track: track,
                              isPlaying: isPlaying,
                              onTap: () => _onTrackTap(tracks, index),
                              onMenuTap: () => _onTrackMenuTap(index),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        },
      ),
    );
  }
}
