import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/featured_playlists_state.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/domain/state/user_state.dart';
import 'package:go_sport/features/music/presentation/music/music_dashboard_controller.dart';
import 'package:go_sport/features/music/presentation/widgets/music_quick_action_card.dart';
import 'package:go_sport/features/music/presentation/widgets/music_screen_skeleton.dart';
import 'package:go_sport/features/music/presentation/widgets/artist_card.dart';
import 'package:go_sport/features/music/presentation/widgets/album_card.dart';
import 'package:go_sport/features/shared_widgets/featured_playlists.dart';

import '../../../shared_widgets/user_avatar_button.dart';
import '../../../shared_widgets/search_button.dart';
import '../../../shared_widgets/wave_section_header.dart';

class MusicScreen extends ConsumerStatefulWidget {
  const MusicScreen({super.key});

  @override
  ConsumerState<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends ConsumerState<MusicScreen> {
  double appBarOpacity = 0;

  @override
  Widget build(BuildContext context) {
    final playlistsState = ref.watch(featuredPlaylistsStateProvider);
    final avatarUrl = ref.watch(userStateProvider.select((s) => s.user?.avatar));
    final playlists = playlistsState.playlistsList;

    final musicDashboardState = ref.watch(musicStateProvider);
    final featuredArtists = musicDashboardState.featuredArtists;
    final featuredAlbums = musicDashboardState.featuredAlbums;

    final favoritesCount = ref.watch(
      likeRegistryProvider.select((s) => s.likedTracks.length),
    );
    final playlistsCount = ref.watch(
      likeRegistryProvider.select((s) => s.likedPlaylists.length),
    );
    final albumsCount = ref.watch(
      likeRegistryProvider.select((s) => s.likedAlbums.length),
    );
    final artistsCount = ref.watch(
      likeRegistryProvider.select((s) => s.likedArtists.length),
    );
    final episodesCount = ref.watch(
      likeRegistryProvider.select((s) => s.likedEpisodes.length),
    );
    final programsCount = ref.watch(
      likeRegistryProvider.select((s) => s.likedPrograms.length),
    );

    // Quick action cards data
    final cards = [
      {
        'icon': SvgPicture.asset('assets/icons/heart_bg.svg'),
        'title': 'My Favorites',
        'subtitle': favoritesCount > 0
            ? '$favoritesCount favorites'
            : 'No favorites',
        'onTap': () => context.push('/music/myfavorites'),
      },
      {
        'icon': SvgPicture.asset('assets/icons/playlists_bg.svg'),
        'title': 'My Playlists',
        'subtitle': playlistsCount > 0
            ? '$playlistsCount playlists'
            : 'No playlists',
        'onTap': () => context.push('/music/myplaylists'),
      },
      {
        'icon': SvgPicture.asset('assets/icons/nota_bg.svg'),
        'title': 'My Albums',
        'subtitle': albumsCount > 0 ? '$albumsCount albums' : 'No albums',
        'onTap': () => context.push('/music/myalbums'),
      },
      {
        'icon': SvgPicture.asset('assets/icons/artist_bg.svg'),
        'title': 'My Artists',
        'subtitle': artistsCount > 0 ? '$artistsCount artists' : 'No artists',
        'onTap': () => context.push('/music/myartists'),
      },
      {
        'icon': SvgPicture.asset('assets/icons/episodes_bg.svg'),
        'title': 'My Episodes',
        'subtitle': episodesCount > 0
            ? '$episodesCount episodes'
            : 'No episodes',
        'onTap': () => context.push('/music/myepisodes'),
      },
      {
        'icon': SvgPicture.asset('assets/icons/programs_bg.svg'),
        'title': 'My Programs',
        'subtitle': programsCount > 0
            ? '$programsCount programs'
            : 'No programs',
        'onTap': () => context.push('/music/myprograms'),
      },
    ];

    final showQuickActionsSkeleton = musicDashboardState.isLoading;
    final showPlaylistsSkeleton = playlistsState.isLoading && playlists.isEmpty;
    final showAlbumsSkeleton =
        musicDashboardState.isLoading && featuredAlbums.isEmpty;
    final showArtistsSkeleton =
        musicDashboardState.isLoading && featuredArtists.isEmpty;

    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: DSColors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/music_bg.png',
            width: screenWidth,
            fit: BoxFit.cover,
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.axis == Axis.vertical) {
                double offset = scrollInfo.metrics.pixels;
                double newOpacity = (offset / 250).clamp(0, 1);

                if (newOpacity != appBarOpacity) {
                  setState(() {
                    appBarOpacity = newOpacity;
                  });
                }
              }

              return false;
            },
            child: RefreshIndicator(
              onRefresh: () => Future.wait([
                ref.read(musicStateProvider.notifier).refresh(),
                ref.read(featuredPlaylistsStateProvider.notifier).refresh(),
              ]),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                // controller: _scrollController,
                slivers: [
                  /// 🔹 AppBar
                  SliverAppBar(
                    backgroundColor: DSColors.white.withValues(
                      alpha: appBarOpacity,
                    ),
                    elevation: 0,
                    pinned: true,
                    floating: true,

                    leading: Padding(
                      padding: const EdgeInsets.only(
                        top: DSSpacing.s8,
                        bottom: DSSpacing.s8,
                        left: DSSpacing.m,
                      ),
                      child: UserAvatarButton(
                        imageUrl: avatarUrl,
                        onTap: () {
                          context.push(AppRoutes.profile);
                        },
                      ),
                    ),
                    title: Text('Music', style: context.h2),
                    centerTitle: true,
                    actions: [const SearchButton()],
                  ),

                  SliverToBoxAdapter(
                    child: showQuickActionsSkeleton
                        ? MusicQuickActionsSkeleton(
                            cardWidth: (screenWidth - 16 * 2 - 8) / 2,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(DSSpacing.m),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: cards.map((card) {
                                return SizedBox(
                                  width: (screenWidth - 16 * 2 - 8) / 2,
                                  child: MusicQuickActionCard(
                                    icon: card['icon'] as SvgPicture,
                                    title: card['title'] as String,
                                    subtitle: card['subtitle'] as String,
                                    onTap: () {
                                      final onTap =
                                          card['onTap'] as VoidCallback?;
                                      if (onTap != null) onTap();
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                  ),

                  // rounded corners box
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: DSColors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(DSRadius.m),
                          topRight: Radius.circular(DSRadius.m),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(height: DSSpacing.m),
                    ),
                  ),

                  // playlist section
                  showPlaylistsSkeleton
                      ? const SliverToBoxAdapter(
                          child: MusicPlaylistsSkeletonSection(),
                        )
                      : FeaturedPlaylistsSection(playlists: playlists),

                  // albums title
                  SliverToBoxAdapter(
                    child: showAlbumsSkeleton
                        ? const MusicAlbumsSkeletonSection()
                        : Container(
                            color: DSColors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: WaveSectionHeader(
                                    title: 'Featured albums',
                                    showAnimation: true,
                                  ),
                                ),
                                if (featuredAlbums.isNotEmpty)
                                  SizedBox(
                                    height: 240,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      itemCount: featuredAlbums.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 12,
                                          ),
                                          child: AlbumCard(
                                            id: featuredAlbums[index].id,
                                            title: featuredAlbums[index].title,
                                            artist:
                                                featuredAlbums[index].artist,
                                            imageUrl:
                                                featuredAlbums[index].imageUrl,
                                            trackCount: featuredAlbums[index]
                                                .trackCount,
                                            onTap: () {
                                              context.push(
                                                '/music/album/${featuredAlbums[index].id}',
                                                extra: featuredAlbums[index],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                  ),

                  // featured artists section
                  SliverToBoxAdapter(
                    child: showArtistsSkeleton
                        ? const MusicArtistsSkeletonSection()
                        : Container(
                            color: DSColors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: DSSpacing.m,
                                  ),
                                  child: WaveSectionHeader(
                                    title: 'Featured artists',
                                    showAnimation: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 170,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    itemCount: featuredArtists.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: DSSpacing.m,
                                        ),
                                        child: ArtistCard(
                                          name:
                                              featuredArtists[index].artistName,
                                          imageUrl:
                                              featuredArtists[index].imageUrl,
                                          onTap: () {
                                            context.push(
                                              '/music/artist/${featuredArtists[index].id}',
                                              extra: featuredArtists[index],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
