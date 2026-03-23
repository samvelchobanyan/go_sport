import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_sport/core/navigation/main_shell.dart';
import 'package:go_sport/core/navigation/page_transitions.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/features/favorite_albums/presentation/albums_list_screen.dart';
import 'package:go_sport/features/favorite_artists/presentation/artists_list/artists_list_screen.dart';
import 'package:go_sport/features/favorite_playlists/presentation/playlists_list_screen.dart';
import 'package:go_sport/features/home/presentation/home/home_screen.dart';
import 'package:go_sport/features/music/presentation/music/music_screen.dart';
import 'package:go_sport/features/radio/presentation/radio/radio_screen.dart';
import 'package:go_sport/features/news/presentation/news_list/news_list_screen.dart';
import 'package:go_sport/features/news/presentation/news_detail/news_detail_screen.dart';
import 'package:go_sport/features/favorite_songs/presentation/songs_list/songs_list_screen.dart';
import 'package:go_sport/features/favorite_episodes/presentation/episodes_list/episodes_list_screen.dart';
import 'package:go_sport/features/favorite_programs/presentation/programs_list_screen.dart';
import 'package:go_sport/features/playlists/presentation/playlist/playlist_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomeScreen(),
              routes: [
                // News routes (nested in Home branch)
                GoRoute(
                  path: 'news',
                  pageBuilder: (context, state) => fadeSlidePage(
                    state: state,
                    child: const NewsListScreen(),
                  ),
                ),
                GoRoute(
                  path: 'news/:id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return fadeSlidePage(
                      state: state,
                      child: NewsDetailScreen(articleId: id),
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // Music Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.music,
              builder: (context, state) => const MusicScreen(),
              routes: [
                //playlist route
                GoRoute(
                  path: 'playlist/:id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return fadeSlidePage(
                      state: state,
                      child: PlaylistScreen(playlistId: id),
                    );
                  },
                ),
                // Favorites route
                GoRoute(
                  path: 'myfavorites',
                  builder: (context, state) => const FavoriteSongsListScreen(),
                ),
                // My Playlists route
                GoRoute(
                  path: 'myplaylists',
                  builder: (context, state) =>
                      const FavoritePlaylistsListScreen(),
                ),
                // My Albums route
                GoRoute(
                  path: 'myalbums',
                  builder: (context, state) => const FavoriteAlbumsListScreen(),
                ),
                // My Artists route
                GoRoute(
                  path: 'myartists',
                  builder: (context, state) =>
                      const FavoriteArtistsListScreen(),
                ),
                // Episodes route
                GoRoute(
                  path: 'myepisodes',
                  builder: (context, state) =>
                      const FavoriteEpisodesListScreen(),
                ),

                // My Programs route
                GoRoute(
                  path: 'myprograms',
                  builder: (context, state) =>
                      const FavoriteProgramsListScreen(),
                ),
              ],
            ),
          ],
        ),

        // Radio Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.radio,
              builder: (context, state) => const RadioScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
