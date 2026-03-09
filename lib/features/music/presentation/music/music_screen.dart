import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/state/featured_playlists_state.dart';
import 'package:go_sport/features/music/presentation/albums_controller.dart';
import 'package:go_sport/features/music/presentation/featured_artists_controller.dart';
import 'package:go_sport/features/music/presentation/music/music_dashboard_controller.dart';
import 'package:go_sport/features/music/presentation/widgets/music_quick_action_card.dart';
import 'package:go_sport/features/music/presentation/widgets/artist_card.dart';
import 'package:go_sport/features/music/presentation/widgets/album_card.dart';
import 'package:go_sport/features/shared_widgets/playlist_card.dart';

import '../../../shared_widgets/user_avatar_button.dart';
import '../../../shared_widgets/search_button.dart';
import '../../../shared_widgets/wave_section_header.dart';

class MusicScreen extends ConsumerWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsState = ref.watch(featuredPlaylistsStateProvider);
    final playlists = playlistsState.playlistsList;
    final albumsState = ref.watch(albumsStateProvider);
    final albums = albumsState.albumsList;
    final artistsState = ref.watch(featuredArtistsStateProvider);
    final artists = artistsState.artistsList;
    final musicDashboardState = ref.watch(musicStateProvider);
    final artistsCount = musicDashboardState.artistsCount;
    final albumsCount = musicDashboardState.albumsCount;
    final playlistsCount = musicDashboardState.playlistsCount;
    final episodesCount = musicDashboardState.episodesCount;
    final programsCount = musicDashboardState.programsCount;
    final favoritesCount = musicDashboardState.favoritesCount;

    // Quick action cards data
    final cards = [
      {
        'icon': SvgPicture.asset('assets/icons/heart_bg.svg'),
        'title': 'My Favorites',
        'subtitle': favoritesCount > 0
            ? '$favoritesCount favorites'
            : 'No favorites',
      },
      {
        'icon': SvgPicture.asset('assets/icons/playlists_bg.svg'),
        'title': 'My Playlist',
        'subtitle': playlistsCount > 0
            ? '$playlistsCount playlists'
            : 'No playlists',
      },
      {
        'icon': SvgPicture.asset('assets/icons/nota_bg.svg'),
        'title': 'My Albums',
        'subtitle': albumsCount > 0 ? '$albumsCount albums' : 'No albums',
      },
      {
        'icon': SvgPicture.asset('assets/icons/artist_bg.svg'),
        'title': 'My Artists',
        'subtitle': artistsCount > 0 ? '$artistsCount artists' : 'No artists',
      },
      {
        'icon': SvgPicture.asset('assets/icons/episodes_bg.svg'),
        'title': 'New Episodes',
        'subtitle': episodesCount > 0
            ? '$episodesCount episodes'
            : 'No episodes',
      },
      {
        'icon': SvgPicture.asset('assets/icons/programs_bg.svg'),
        'title': 'My Programs',
        'subtitle': programsCount > 0
            ? '$programsCount programs'
            : 'No programs',
      },
    ];

    final isLoading = playlistsState.isLoading && playlists.isEmpty;
    final hasError = playlistsState.error != null;
    final errorMessage = playlistsState.error;

    return Scaffold(
      backgroundColor: DSColors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (hasError && playlists.isEmpty)
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: DSColors.errorColor,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      errorMessage ?? 'Error loading data',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(featuredPlaylistsStateProvider.notifier)
                          .refresh(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          : (playlists.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No content yet'),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => ref
                        .read(featuredPlaylistsStateProvider.notifier)
                        .refresh(),
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(featuredPlaylistsStateProvider.notifier).refresh(),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/music_bg.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  CustomScrollView(
                    slivers: [
                      /// 🔹 AppBar
                      SliverAppBar(
                        backgroundColor: DSColors.transparent,
                        elevation: 0,
                        pinned: false,
                        floating: false,
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserAvatarButton(
                            imageUrl: null,
                            onTap: () {
                              // TODO: navigate to profile
                            },
                          ),
                        ),
                        title: Text('Music', style: context.h2),
                        centerTitle: true,
                        actions: [
                          SearchButton(
                            onTap: () {
                              // TODO: open music search
                            },
                          ),
                        ],
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: cards.map((card) {
                              return SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width -
                                        16 * 2 -
                                        8) /
                                    2,
                                child: MusicQuickActionCard(
                                  icon: card['icon'] as SvgPicture,
                                  title: card['title'] as String,
                                  subtitle: card['subtitle'] as String,
                                  onTap: () {
                                    final title = card['title'] as String;
                                    switch (title) {
                                      case 'My Favorites':
                                        context.push('/music/favorites');
                                        break;
                                      case 'My Playlist':
                                        context.push('/music/myplaylists');
                                        break;
                                      case 'My Albums':
                                        context.push('/music/myalbums');
                                        break;
                                      case 'My Artists':
                                        context.push('/music/myartists');
                                        break;
                                      case 'New Episodes':
                                        context.push('/music/episodes');
                                        break;
                                      case 'My Programs':
                                        context.push('/music/myprograms');
                                        break;
                                      default:
                                        debugPrint('Unknown card: $title');
                                    }
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
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: SizedBox(height: 16),
                        ),
                      ),

                      // playlist title
                      SliverToBoxAdapter(
                        child: Container(
                          color: DSColors.white, // whole section background
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Section header
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: WaveSectionHeader(
                                  title: 'Featured playlists',
                                  showAnimation: true,
                                ),
                              ),

                              // playlist list
                              if (playlists.isNotEmpty)
                                SizedBox(
                                  height: 210,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    itemCount: playlists.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        child: PlaylistCard(
                                          id: playlists[index].id,
                                          title: playlists[index].title,
                                          imageUrl: playlists[index].imageUrl,
                                          trackCount:
                                              playlists[index].trackCount,
                                          onTap: () {
                                            print(
                                              'Playlist tapped: ${playlists[index].id}',
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

                      // albums title
                      SliverToBoxAdapter(
                        child: Container(
                          color: DSColors.white, // whole section background
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Section header
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: WaveSectionHeader(
                                  title: 'Featured albums',
                                  showAnimation: true,
                                ),
                              ),

                              // albums list
                              if (albums.isNotEmpty)
                                SizedBox(
                                  height: 260,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    itemCount: albums.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        child: AlbumCard(
                                          id: albums[index].id,
                                          title: albums[index].title,
                                          artist: albums[index].artist,
                                          imageUrl: albums[index].imageUrl,
                                          trackCount: albums[index].trackCount,
                                          onTap: () {
                                            print(
                                              'Album tapped: ${albums[index].id}',
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
                        child: Container(
                          color: DSColors.white, // whole section background
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Section header
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: WaveSectionHeader(
                                  title: 'Featured artists',
                                  showAnimation: true,
                                ),
                              ),

                              // artists list (state-driven)
                              if (artistsState.isLoading)
                                SizedBox(
                                  height: 170,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: DSColors.blue,
                                    ),
                                  ),
                                )
                              else if (artists.isEmpty)
                                const SizedBox.shrink()
                              else
                                SizedBox(
                                  height: 170,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    itemCount: artists.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 16,
                                        ),
                                        child: ArtistCard(
                                          name: artists[index].title,
                                          imageUrl: artists[index].imageUrl,
                                          onTap: () {
                                            print(
                                              'Artist tapped: ${artists[index].id}',
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
                ],
              ),
            ),
    );
  }
}
