import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
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
  /// Album id — the only thing required to open the screen. Navigations that
  /// already hold the full [Album] (lists, search) pass it as [albumHint]
  /// for an instant first paint; the track options sheet passes only the id.
  final String albumId;
  final Album? albumHint;

  const AlbumScreen({super.key, required this.albumId, this.albumHint});

  @override
  ConsumerState<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends ConsumerState<AlbumScreen> {
  void _onTrackTap(Album album, List<Track> tracks, int index) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          tracks,
          source: QueueSource.album(
            id: album.id,
            title: album.title,
            imageUrl: album.imageUrl,
          ),
          startIndex: index,
        );
  }

  void _onPlayTap(Album album, List<Track> tracks, bool isThisActiveSource) {
    if (isThisActiveSource) {
      ref.read(playerStateProvider.notifier).togglePlayPause();
      return;
    }
    if (tracks.isEmpty) return;
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          tracks,
          source: QueueSource.album(
            id: album.id,
            title: album.title,
            imageUrl: album.imageUrl,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final tracksState = ref.watch(albumControllerProvider(widget.albumId));
    final isLiked = ref.watch(
      likeRegistryProvider.select(
        (s) => s.likedAlbums.any((a) => a.id == widget.albumId),
      ),
    );
    final isThisActiveSource = ref.watch(
      playerStateProvider.select(
        (s) => s.source?.id == widget.albumId && !s.isRadioMode,
      ),
    );
    final isThisPlaying = ref.watch(
      playerStateProvider.select(
        (s) => s.source?.id == widget.albumId && s.isPlaying && !s.isRadioMode,
      ),
    );

    // Prefer the navigation hint for the hero — its cover URL is already
    // cached by the list we came from. The freshly loaded album is used only
    // for id-only opens (track options sheet). Null only while an id-only
    // load is still in flight.
    final loadedAlbum = tracksState.whenOrNull(data: (album, tracks) => album);
    final album = widget.albumHint ?? loadedAlbum;
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
              icon: SvgPicture.asset('assets/icons/arrow-Left.svg'),
              onPressed: () => context.pop(),
            ),
            actions: [
              // Share — functionality not implemented yet, hidden for now.
              // IconButton(
              //   icon: SvgPicture.asset('assets/icons/share_no_bg.svg'),
              //   onPressed: () {},
              // ),
              const SearchButton(iconColor: DSColors.white),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: album == null
                  // Id-only open: album not loaded yet — plain backdrop until
                  // the network fills it in.
                  ? const ColoredBox(color: DSColors.black)
                  : AlbumHero(
                      album: album,
                      isLiked: isLiked,
                      isPlaying: isThisPlaying,
                      onLikeTap: () => ref
                          .read(likeRegistryProvider.notifier)
                          .toggleAlbumLike(album),
                      onPlayTap: () {
                        final tracks = tracksState.mapOrNull(
                          data: (data) => data.tracks,
                        );
                        if (tracks != null) {
                          _onPlayTap(album, tracks, isThisActiveSource);
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
                    top: Radius.circular(DSRadius.xl),
                  ),
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
                    const SizedBox(height: DSSpacing.m),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(
                            albumControllerProvider(widget.albumId).notifier,
                          )
                          .loadTracks(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
            data: (loadedAlbum, tracks) {
              // Narrow selects: position ticks must not rebuild the list.
              final playingTrackId = ref.watch(
                playerStateProvider.select((s) => s.currentTrack?.id),
              );
              final isPlaying = ref.watch(
                playerStateProvider.select(
                  (s) => s.isPlaying && !s.isRadioMode,
                ),
              );

              return SliverPadding(
                padding: const EdgeInsets.only(
                  bottom: DSLayout.bottomBarClearance,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final track = tracks[index];
                    final isCurrentTrack = track.id == playingTrackId;
                    final bool? trackPlayingState = isCurrentTrack
                        ? isPlaying
                        : null;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AlbumTrackTile(
                          track: track,
                          index: index + 1,
                          isPlaying: trackPlayingState,
                          onTap: () => _onTrackTap(loadedAlbum, tracks, index),
                          onMenuTap: () {},
                          topPadding: index == 0 ? 0 : 8,
                        ),
                        if (index < tracks.length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: DSSpacing.m,
                            ),
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
