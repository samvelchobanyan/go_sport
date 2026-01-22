import 'package:go_router/go_router.dart';
import 'package:go_sport/core/navigation/main_shell.dart';
import 'package:go_sport/core/navigation/page_transitions.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/features/home/presentation/home/home_screen.dart';
import 'package:go_sport/features/music/presentation/music/music_screen.dart';
import 'package:go_sport/features/radio/presentation/radio/radio_screen.dart';
import 'package:go_sport/features/news/presentation/news_list/news_list_screen.dart';
import 'package:go_sport/features/news/presentation/news_detail/news_detail_screen.dart';

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
