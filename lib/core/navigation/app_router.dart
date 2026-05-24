import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/auth/token_storage.dart';
import 'package:go_sport/core/navigation/main_shell.dart';
import 'package:go_sport/core/navigation/page_transitions.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/features/auth/change_password/presentation/change_password_screen.dart';
import 'package:go_sport/features/auth/check_email/presentation/check_email_screen.dart';
import 'package:go_sport/features/auth/confirm_change_password/presentation/confirm_change_password_screen.dart';
import 'package:go_sport/features/auth/confirm_email/presentation/confirm_email_screen.dart';
import 'package:go_sport/features/auth/confirm_phone/presentation/confirm_phone_screen.dart';
import 'package:go_sport/features/auth/create_password/presentation/create_password_screen.dart';
import 'package:go_sport/features/auth/expired_guest/presentation/expired_guest.dart';
import 'package:go_sport/features/auth/registration_name/presentation/registration_name_screen.dart';
import 'package:go_sport/features/auth/forgot_password/presentation/forgot_password_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_albums/my_albums_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_artists/my_artists_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_playlists/my_playlists_screen.dart';
import 'package:go_sport/features/user_profile/change_password/presentation/change_password/change_password_screen.dart';
import 'package:go_sport/features/user_profile/confirm_delete/presentation/confirm_delete/confirm_delete_screen.dart';
import 'package:go_sport/features/user_profile/delete/presentation/delete_screen.dart';
import 'package:go_sport/features/user_profile/delete_success/presentation/delete_success/delete_success_screen.dart';
import 'package:go_sport/features/user_profile/edit_profile/presentation/edit_profile/edit_profile_screen.dart';
import 'package:go_sport/features/user_profile/for_business/presentation/for_business_screen.dart';
import 'package:go_sport/features/home/presentation/home/home_screen.dart';
import 'package:go_sport/features/auth/login/presentation/login/login_screen.dart';
import 'package:go_sport/features/auth/registration_phone/presentation/registration_phone_screen.dart';
import 'package:go_sport/features/auth/registration_email/presentation/registration_email_screen.dart';
import 'package:go_sport/features/music/presentation/music/music_screen.dart';
import 'package:go_sport/features/user_profile/notifications/presentation/notifications/notifications_screen.dart';
import 'package:go_sport/features/user_profile/profile/presentation/profile/profile_screen.dart';
import 'package:go_sport/features/news/presentation/news_list/news_list_screen.dart';
import 'package:go_sport/features/news/presentation/news_detail/news_detail_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_favorites/my_favorites_screen.dart';
import 'package:go_sport/features/favorites/presentation/new_episodes/new_episodes_screen.dart';
import 'package:go_sport/features/favorites/presentation/my_programs/my_programs_screen.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/features/albums/presentation/album/album_screen.dart';
import 'package:go_sport/features/artists/presentation/artist/artist_screen.dart';
import 'package:go_sport/features/playlists/presentation/playlist/playlist_screen.dart';
import 'package:go_sport/features/program_details/presentation/program_details/program_details_screen.dart';
import 'package:go_sport/features/radio/presentation/radio/radio_page_screen.dart';
import 'package:go_sport/features/schedule/presentation/schedule/schedule_screen.dart';

final GlobalKey<NavigatorState> _homeBranchNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeBranchNavigator');
final GlobalKey<NavigatorState> _musicBranchNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'musicBranchNavigator');
final GlobalKey<NavigatorState> _radioBranchNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'radioBranchNavigator');

GlobalKey<NavigatorState>? _branchNavigatorKeyResolver(int branchIndex) {
  switch (branchIndex) {
    case 0:
      return _homeBranchNavigatorKey;
    case 1:
      return _musicBranchNavigatorKey;
    case 2:
      return _radioBranchNavigatorKey;
    default:
      return null;
  }
}

GoRouter createAppRouter(TokenStorage tokenStorage) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final isAuthenticated = tokenStorage.accessToken != null;
      final isGuest = tokenStorage.choseGuest;
      final isPrivateRoute = AppRoutes.privateRoutes.contains(
        state.matchedLocation,
      );

      final isAuthFlow =
          // login
          state.matchedLocation == AppRoutes.login ||
          // registration
          state.matchedLocation == AppRoutes.registrationEmail ||
          state.matchedLocation == AppRoutes.registrationPhone ||
          state.matchedLocation == AppRoutes.registrationName ||
          state.matchedLocation == AppRoutes.confirmEmail ||
          state.matchedLocation == AppRoutes.createPassword ||
          // forget password flow
          state.matchedLocation == AppRoutes.forgotPassword ||
          state.matchedLocation == AppRoutes.checkEmail ||
          state.matchedLocation == AppRoutes.changePassword ||
          state.matchedLocation == AppRoutes.confirmChangePassword;

      // unauthorized (первый запуск) — гоним на логин со всех маршрутов кроме самого логина
      if (!isAuthenticated && !isGuest && !isAuthFlow) {
        return AppRoutes.login;
      }

      // приватный маршрут — только для authenticated
      if (!isAuthenticated && isPrivateRoute) {
        return AppRoutes.login;
      }

      // уже залогинен — незачем показывать логин
      if (isAuthenticated && isAuthFlow) {
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
        path: AppRoutes.registrationEmail,
        builder: (context, state) => const RegistrationEmailScreen(),
      ),
      GoRoute(
        path: AppRoutes.registrationPhone,
        builder: (context, state) => const RegistrationPhoneScreen(),
      ),
      GoRoute(
        path: AppRoutes.registrationName,
        builder: (context, state) => const RegistrationNameScreen(),
      ),
      GoRoute(
        path: AppRoutes.confirmEmail,
        builder: (context, state) => const ConfirmEmailScreen(),
      ),

      GoRoute(
        path: AppRoutes.confirmPhone,
        builder: (context, state) => const ConfirmPhoneScreen(),
      ),

      GoRoute(
        path: AppRoutes.createPassword,
        builder: (context, state) => const CreatePasswordScreen(),
      ),

      GoRoute(
        path: AppRoutes.profile,
        pageBuilder: (context, state) =>
            fadeSlidePage(state: state, child: const ProfileScreen()),
        routes: [
          GoRoute(
            path: 'for-business',
            pageBuilder: (context, state) =>
                fadeSlidePage(state: state, child: const ForBusinessScreen()),
          ),
          GoRoute(
            path: 'edit-profile',
            pageBuilder: (context, state) =>
                fadeSlidePage(state: state, child: const EditProfileScreen()),
          ),
          GoRoute(
            path: 'change-password',
            pageBuilder: (context, state) => fadeSlidePage(
              state: state,
              child: const ProfileChangePasswordScreen(),
            ),
          ),
          GoRoute(
            path: 'delete-account',
            pageBuilder: (context, state) =>
                fadeSlidePage(state: state, child: const DeleteScreen()),
          ),
          GoRoute(
            path: 'confirm-delete',
            pageBuilder: (context, state) =>
                fadeSlidePage(state: state, child: const ConfirmDeleteScreen()),
          ),
          GoRoute(
            path: 'delete-success',
            pageBuilder: (context, state) =>
                fadeSlidePage(state: state, child: const DeleteSuccessScreen()),
          ),
          GoRoute(
            path: 'notifications',
            pageBuilder: (context, state) =>
                fadeSlidePage(state: state, child: const NotificationsScreen()),
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.expiredGuest,
        builder: (context, state) => const ExpiredGuestScreen(),
      ),

      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      GoRoute(
        path: AppRoutes.checkEmail,
        builder: (context, state) => const CheckEmailScreen(),
      ),

      GoRoute(
        path: AppRoutes.changePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),

      GoRoute(
        path: AppRoutes.confirmChangePassword,
        builder: (context, state) => const ConfirmChangePasswordScreen(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(
            navigationShell: navigationShell,
            branchNavigatorKeyResolver: _branchNavigatorKeyResolver,
          );
        },
        branches: [
          // Home Branch
          StatefulShellBranch(
            navigatorKey: _homeBranchNavigatorKey,
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
            navigatorKey: _musicBranchNavigatorKey,
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
                  // Artist route
                  GoRoute(
                    path: 'artist/:id',
                    pageBuilder: (context, state) {
                      final artist = state.extra as Artist;
                      return fadeSlidePage(
                        state: state,
                        child: ArtistScreen(artist: artist),
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

                  // Program details route
                  GoRoute(
                    path: 'program/:id',
                    pageBuilder: (context, state) {
                      final program = state.extra as Program;
                      return fadeSlidePage(
                        state: state,
                        child: ProgramDetailsScreen(program: program),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Radio Branch
          StatefulShellBranch(
            navigatorKey: _radioBranchNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.radio,
                builder: (context, state) => const RadioPageScreen(),
                routes: [
                  GoRoute(
                    path: 'schedule',
                    builder: (context, state) => const ScheduleScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
