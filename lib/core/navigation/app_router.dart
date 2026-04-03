import 'package:go_router/go_router.dart';
import 'package:go_sport/core/auth/token_storage.dart';
import 'package:go_sport/core/navigation/main_shell.dart';
import 'package:go_sport/core/navigation/page_transitions.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/features/auth/presentation/login/login_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_albums/my_albums_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_artists/my_artists_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_playlists/my_playlists_screen.dart';
import 'package:go_sport/features/home/presentation/home/home_screen.dart';
import 'package:go_sport/features/music/presentation/music/music_screen.dart';
import 'package:go_sport/features/radio/presentation/radio/radio_screen.dart';
import 'package:go_sport/features/news/presentation/news_list/news_list_screen.dart';
import 'package:go_sport/features/news/presentation/news_detail/news_detail_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_favorites/my_favorites_screen.dart';
import 'package:go_sport/features/favorites/presentation/new_episodes/new_episodes_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_programs/my_programs_screen.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/features/albums/presentation/album/album_screen.dart';
import 'package:go_sport/features/playlists/presentation/playlist/playlist_screen.dart';
import 'package:go_sport/features/profile/presentation/profile/profile_screen.dart';

GoRouter createAppRouter(TokenStorage tokenStorage) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final isAuthenticated = tokenStorage.accessToken != null;
      final isGuest = tokenStorage.choseGuest;
      final isLoginRoute = state.matchedLocation == AppRoutes.login;
      final isPrivateRoute = AppRoutes.privateRoutes.contains(state.matchedLocation);

      // unauthorized (первый запуск) — гоним на логин со всех маршрутов кроме самого логина
      if (!isAuthenticated && !isGuest && !isLoginRoute) {
        return AppRoutes.login;
      }

      // приватный маршрут — только для authenticated
      if (!isAuthenticated && isPrivateRoute) {
        return AppRoutes.login;
      }

      // уже залогинен — незачем показывать логин
      if (isAuthenticated && isLoginRoute) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: const ProfileScreen(),
        ),
      ),
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
                  // Album route
                  GoRoute(
                    path: 'album/:id',
                    pageBuilder: (context, state) {
                      final album = state.extra as Album;
                      return fadeSlidePage(
                        state: state,
                        child: AlbumScreen(album: album),
                      );
                    },
                  ),
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
                    builder: (context, state) => const MyFavoritesScreen(),
                  ),
                  // My Playlists route
                  GoRoute(
                    path: 'myplaylists',
                    builder: (context, state) => const MyPlaylistsScreen(),
                  ),
                  // My Albums route
                  GoRoute(
                    path: 'myalbums',
                    builder: (context, state) => const MyAlbumsScreen(),
                  ),
                  // My Artists route
                  GoRoute(
                    path: 'myartists',
                    builder: (context, state) => const MyArtistsScreen(),
                  ),
                  // Episodes route
                  GoRoute(
                    path: 'myepisodes',
                    builder: (context, state) => const NewEpisodesScreen(),
                  ),

                  // My Programs route
                  GoRoute(
                    path: 'myprograms',
                    builder: (context, state) => const MyProgramsScreen(),
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
}
