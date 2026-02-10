import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_sport/core/navigation/main_shell.dart';
import 'package:go_sport/core/navigation/page_transitions.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/features/home/presentation/home/home_screen.dart';
import 'package:go_sport/features/music/presentation/music/music_screen.dart';
import 'package:go_sport/features/radio/presentation/radio/radio_screen.dart';
import 'package:go_sport/features/news/presentation/news_list/news_list_screen.dart';
import 'package:go_sport/features/news/presentation/news_detail/news_detail_screen.dart';
import 'package:go_sport/features/favorites/presentation/favorites_list/favorites_list_screen.dart';
import 'package:go_sport/features/episodes/presentation/episodes_list/episodes_list_screen.dart';
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
              ],
            ),
            GoRoute(
              path: AppRoutes.music,
              builder: (context, state) => const MusicScreen(),
              routes: [
                // Favorites route
                GoRoute(
                  path: 'favorites',
                  builder: (context, state) => const FavoritesListScreen(),
                ),
                // My Playlists route
                GoRoute(
                  path: 'myplaylists',
                  builder: (context, state) {
                    // TODO: Create MyPlaylistsScreen
                    return const Scaffold(
                      body: Center(child: Text('My Playlists')),
                    );
                  },
                ),
                // My Albums route
                GoRoute(
                  path: 'myalbums',
                  builder: (context, state) {
                    // TODO: Create MyAlbumsScreen
                    return const Scaffold(
                      body: Center(child: Text('My Albums')),
                    );
                  },
                ),
                // My Artists route
                GoRoute(
                  path: 'myartists',
                  builder: (context, state) {
                    // TODO: Create MyArtistsScreen
                    return const Scaffold(
                      body: Center(child: Text('My Artists')),
                    );
                  },
                ),
                // Episodes route
                GoRoute(
                  path: 'episodes',
                  builder: (context, state) => const EpisodesListScreen(),
                ),

                // My Programs route
                GoRoute(
                  path: 'myprograms',
                  builder: (context, state) {
                    // TODO: Create MyProgramsScreen
                    return const Scaffold(
                      body: Center(child: Text('My Programs')),
                    );
                  },
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
