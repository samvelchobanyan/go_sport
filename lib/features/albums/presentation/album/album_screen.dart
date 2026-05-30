import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/albums/presentation/album/album_controller.dart';
import 'package:go_sport/features/albums/presentation/widgets/album_hero.dart';
import 'package:go_sport/features/albums/presentation/widgets/album_screen_skeleton.dart';
import 'package:go_sport/features/albums/presentation/widgets/album_track_tile.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/search_button.dart';

class AlbumScreen extends ConsumerStatefulWidget {
  final Album album;

  const AlbumScreen({super.key, required this.album});

  @override
  ConsumerState<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends ConsumerState<AlbumScreen> {
  void _onTrackTap(List<Track> tracks, int index) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          tracks,
          source: QueueSource.album(
            id: widget.album.id,
            title: widget.album.title,
            imageUrl: widget.album.imageUrl,
          ),
          startIndex: index,
        );
  }

  void _onPlayTap(List<Track> tracks) {
    if (tracks.isEmpty) return;
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          tracks,
          source: QueueSource.album(
            id: widget.album.id,
            title: widget.album.title,
            imageUrl: widget.album.imageUrl,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final tracksState = ref.watch(albumControllerProvider(widget.album.id));
    final isLiked = ref.watch(
      likeRegistryProvider.select((s) => s.albumLikes.containsKey(widget.album.id)),
    );
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
            backgroundColor: DSColors.black.withValues(alpha: 0.9),
            leading: IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: DSColors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: DSColors.white,
                  size: 20,
                ),
              ),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: DSColors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.share,
                    color: DSColors.white,
                    size: 20,
                  ),
                ),
                onPressed: () {},
              ),
              const SearchButton(decoration: true),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: AlbumHero(
                album: widget.album.copyWith(isLiked: isLiked),
                onLikeTap: () => ref
                    .read(likeRegistryProvider.notifier)
                    .toggleAlbum(widget.album.id),
                onPlayTap: () {
                  final tracks = tracksState.mapOrNull(
                    data: (data) => data.tracks,
                  );
                  if (tracks != null) _onPlayTap(tracks);
                },
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(24),
              child: Container(
                height: 24,
                decoration: const BoxDecoration(
                  color: DSColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
              ),
            ),
          ),
          tracksState.when(
            loading: () => const AlbumScreenSkeleton(),
            error: (message) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $message'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(
                            albumControllerProvider(widget.album.id).notifier,
                          )
                          .loadTracks(),
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
                padding: const EdgeInsets.only(bottom: 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final track = tracks[index];
                    final isCurrentTrack = track.id == playingTrackId;
                    final bool? trackPlayingState = isCurrentTrack
                        ? playerState.isPlaying &&
                              playerState.isRadioMode == false
                        : null;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AlbumTrackTile(
                          track: track,
                          index: index + 1,
                          isPlaying: trackPlayingState,
                          onTap: () => _onTrackTap(tracks, index),
                          onMenuTap: () {},
                        ),
                        if (index < tracks.length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: DottedDivider(),
                          ),
                      ],
                    );
                  }, childCount: tracks.length),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
