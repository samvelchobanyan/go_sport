import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/artists/presentation/artist/artist_controller.dart';
import 'package:go_sport/features/artists/presentation/widgets/artist_screen_skeleton.dart';
import 'package:go_sport/features/artists/presentation/widgets/artist_hero.dart';
import 'package:go_sport/features/artists/presentation/widgets/artist_tab_chips.dart';
import 'package:go_sport/features/playlists/presentation/bottom_sheets/add_to_playlist_bottom_sheet.dart';
import 'package:go_sport/features/shared_widgets/album_tile.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/track_options.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/search_button.dart';
import 'package:go_sport/features/shared_widgets/track_tile.dart';
import 'package:go_sport/features/shared_widgets/wave_section_header.dart';

class ArtistScreen extends ConsumerStatefulWidget {
  /// Artist id — the only thing required to open the screen. Navigations that
  /// already hold the full [Artist] (lists, search) pass it as [artistHint]
  /// for an instant first paint; the player passes only the id.
  final String artistId;
  final Artist? artistHint;

  const ArtistScreen({super.key, required this.artistId, this.artistHint});

  @override
  ConsumerState<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends ConsumerState<ArtistScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    if (widget.artistHint == null) {
      // Player-originated open: no hero data yet — fetch it alongside the
      // tab lists the controller is already loading.
      Future.microtask(
        () => ref
            .read(artistControllerProvider(widget.artistId).notifier)
            .loadArtist(),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(artistControllerProvider(widget.artistId).notifier).loadMore();
    }
  }

  void _onTrackTap(Artist? artist, List<Track> tracks, int index) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          tracks,
          source: QueueSource.artist(
            id: widget.artistId,
            title: artist?.artistName ?? '',
            imageUrl: artist?.imageUrl ?? '',
          ),
          startIndex: index,
        );
  }

  void _onTrackMenuTap(Track track) {
    showTrackOptionsBottomSheet(
      context: context,
      track: track,
      onAddToPlaylist: () =>
          showAddToPlaylistBottomSheet(context: context, track: track),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(artistControllerProvider(widget.artistId));
    final isLiked = ref.watch(
      likeRegistryProvider.select(
        (s) => s.likedArtists.any((a) => a.id == widget.artistId),
      ),
    );

    // Prefer the navigation hint for the hero. Its cover URL is already cached
    // by the list we came from, so keeping it avoids a placeholder flash when
    // the details load returns a different Cover URL for the same artist. The
    // freshly loaded artist is used only for player-originated opens (no
    // hint). Null only while a player-originated load is still in flight.
    final artist = widget.artistHint ?? state.artist;

    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: DSColors.white,
      body: CustomScrollView(
        controller: _scrollController,
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
              background: artist == null
                  // Player-originated open: artist not loaded yet — plain
                  // backdrop until the network fills it in.
                  ? const ColoredBox(color: DSColors.black)
                  : ArtistHero(
                      artist: artist,
                      isLiked: isLiked,
                      onLikeTap: () => ref
                          .read(likeRegistryProvider.notifier)
                          .toggleArtistLike(artist),
                    ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(24),
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                  color: DSColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(DSRadius.xl),
                  ),
                ),
              ),
            ),
          ),
          if (state.isLoading) ...const [
            SliverToBoxAdapter(child: _HeaderSkeleton()),
            ArtistScreenSkeleton(),
          ] else if (state.error != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.error}'),
                    const SizedBox(height: DSSpacing.m),
                    ElevatedButton(
                      onPressed: () {
                        final notifier = ref.read(
                          artistControllerProvider(widget.artistId).notifier,
                        );
                        notifier.loadAll();
                        if (artist == null) notifier.loadArtist();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else ...[
            SliverToBoxAdapter(child: _buildHeader(state)),
            ..._buildTabContent(state, artist),
          ],
        ],
      ),
    );
  }

  /// Chips when the artist has albums or singles besides tracks; a plain
  /// section header when tracks are all there is.
  Widget _buildHeader(ArtistState state) {
    final visibleTabs = [
      ArtistTab.tracks,
      if (state.albums.items.isNotEmpty) ArtistTab.albums,
      if (state.singles.items.isNotEmpty) ArtistTab.singles,
    ];

    if (visibleTabs.length == 1) {
      return const Padding(
        padding: EdgeInsets.only(top: DSSpacing.s8, bottom: DSSpacing.s8),
        child: WaveSectionHeader(title: 'Tracks'),
      );
    }

    return ArtistTabChips(
      tabs: visibleTabs,
      selected: state.selectedTab,
      onTap: (tab) => ref
          .read(artistControllerProvider(widget.artistId).notifier)
          .selectTab(tab),
    );
  }

  List<Widget> _buildTabContent(ArtistState state, Artist? artist) {
    final isLoadingMore = switch (state.selectedTab) {
      ArtistTab.tracks => state.tracks.isLoadingMore,
      ArtistTab.albums => state.albums.isLoadingMore,
      ArtistTab.singles => state.singles.isLoadingMore,
    };

    return [
      switch (state.selectedTab) {
        ArtistTab.tracks => _buildTrackList(state.tracks.items, artist),
        ArtistTab.albums => _buildAlbumsList(state),
        // Singles are plain tracks: same tiles, same tap-to-play behavior.
        ArtistTab.singles => _buildTrackList(state.singles.items, artist),
      },
      SliverToBoxAdapter(
        child: isLoadingMore
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: DSSpacing.m),
                child: Center(child: CircularProgressIndicator()),
              )
            : null,
      ),
    ];
  }

  Widget _buildTrackList(List<Track> tracks, Artist? artist) {
    // Narrow selects: position ticks must not rebuild the list.
    final playingTrackId = ref.watch(
      playerStateProvider.select((s) => s.currentTrack?.id),
    );
    final isPlaying = ref.watch(
      playerStateProvider.select((s) => s.isPlaying && !s.isRadioMode),
    );

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final track = tracks[index];
        final isCurrentTrack = track.id == playingTrackId;
        final bool? trackPlayingState = isCurrentTrack ? isPlaying : null;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TrackTile(
              track: track,
              isPlaying: trackPlayingState,
              onTap: () => _onTrackTap(artist, tracks, index),
              onMenuTap: _onTrackMenuTap,
              topPadding: index == 0 ? 0 : 8,
            ),
            if (index < tracks.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
                child: DottedDivider(),
              ),
          ],
        );
      }, childCount: tracks.length),
    );
  }

  Widget _buildAlbumsList(ArtistState state) {
    final albums = state.albums.items;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final album = albums[index];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AlbumTile(
              imageUrl: album.imageUrl,
              albumName: album.title,
              artistName: album.artist,
              releaseYear: album.releaseYear,
              onTap: () =>
                  context.push('/music/album/${album.id}', extra: album),
              topPadding: index == 0 ? 0 : 8,
            ),
            if (index < albums.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
                child: DottedDivider(),
              ),
          ],
        );
      }, childCount: albums.length),
    );
  }

}

/// Placeholder matching [ArtistTabChips] structure, padding, and height exactly
/// so the screen does not jump when shifting from the skeleton to loaded chips.
class _HeaderSkeleton extends StatelessWidget {
  const _HeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: DSSpacing.s18, // Match 18px bottom padding
        left: DSSpacing.m, // Match 20px horizontal left margin
        right: DSSpacing.m, // Match 20px horizontal right margin
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < 3; i++) ...[
            Container(
              width: 96,
              height:
                  36, // Precise height matching the loaded chip structure (16px content + 20px padding)
              decoration: BoxDecoration(
                color: DSColors.gray20,
                borderRadius: BorderRadius.circular(DSRadius.circular),
              ),
            ),
            if (i < 2)
              const SizedBox(width: DSSpacing.s8), // Identical separation gaps
          ],
        ],
      ),
    );
  }
}
