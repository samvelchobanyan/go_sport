import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/features/artists/presentation/artist/artist_controller.dart';
import 'package:go_sport/features/artists/presentation/widgets/artist_screen_skeleton.dart';
import 'package:go_sport/features/artists/presentation/widgets/artist_hero.dart';
import 'package:go_sport/features/shared_widgets/album_tile.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/search_button.dart';
import 'package:go_sport/features/shared_widgets/wave_section_header.dart';

class ArtistScreen extends ConsumerStatefulWidget {
  final Artist artist;

  const ArtistScreen({super.key, required this.artist});

  @override
  ConsumerState<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends ConsumerState<ArtistScreen> {
  @override
  Widget build(BuildContext context) {
    final albumsState = ref.watch(artistControllerProvider(widget.artist.id));
    final isLiked = ref.watch(
      likeRegistryProvider.select((s) => s.likedArtists.any((a) => a.id == widget.artist.id)),
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
              icon: SvgPicture.asset('assets/icons/arrow-Left.svg'),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: SvgPicture.asset('assets/icons/share_no_bg.svg'),
                onPressed: () {},
              ),
              const SearchButton(iconColor: DSColors.white),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ArtistHero(
                artist: widget.artist,
                isLiked: isLiked,
                onLikeTap: () => ref
                    .read(likeRegistryProvider.notifier)
                    .toggleArtistLike(widget.artist),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(24),
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                  color: DSColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(DSRadius.xl)),
                ),
              ),
            ),
          ),
          albumsState.when(
            loading: () => const SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: DSSpacing.s8, bottom: DSSpacing.m),
                    child: WaveSectionHeader(title: 'Albums'),
                  ),
                ),
                ArtistScreenSkeleton(),
              ],
            ),
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
                            artistControllerProvider(widget.artist.id).notifier,
                          )
                          .loadAlbums(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
            data: (albums) => SliverMainAxisGroup(
              slivers: [
                const SliverToBoxAdapter(
                  child: WaveSectionHeader(title: 'Albums'),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: DSLayout.bottomBarClearance),
                  sliver: SliverList(
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
                            onTap: () => context.push(
                              '/music/album/${album.id}',
                              extra: album,
                            ),
                          ),
                          if (index < albums.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
                              child: DottedDivider(),
                            ),
                        ],
                      );
                    }, childCount: albums.length),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
