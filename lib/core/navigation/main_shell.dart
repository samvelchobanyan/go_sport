import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/core/navigation/widgets/bottom_nav_bar.dart';
import 'package:go_sport/features/auth/guest_timeout_bar/widgets/guest_timer_bar.dart';
import 'package:go_sport/features/player/presentation/player/full_player_screen.dart';
import 'package:go_sport/features/player/presentation/player/mini_player_widget.dart';
import 'package:go_sport/features/player/presentation/player/radio_full_player_screen.dart';

typedef BranchNavigatorKeyResolver = GlobalKey<NavigatorState>? Function(
  int branchIndex,
);

class MainShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  final BranchNavigatorKeyResolver branchNavigatorKeyResolver;

  const MainShell({
    super.key,
    required this.navigationShell,
    required this.branchNavigatorKeyResolver,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuest = ref.watch(authProvider) is AuthGuest;
    final activeBranchNavigatorKey = branchNavigatorKeyResolver(
      navigationShell.currentIndex,
    );
    final activeBranchContext = activeBranchNavigatorKey?.currentContext ??
        context;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MiniPlayerWidget(
            onOpenFullPlayer: () => FullPlayerScreen.show(activeBranchContext),
            onOpenRadioPlayer: () =>
                RadioFullPlayerScreen.show(activeBranchContext),
          ),
          BottomNavBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(index),
          ),
          if (isGuest)
            GuestTimerBar(
              onRegisterTap: () => context.go(AppRoutes.login),
            ),
        ],
      ),
    );
  }
}
