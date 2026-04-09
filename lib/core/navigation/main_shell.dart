import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/core/navigation/widgets/bottom_nav_bar.dart';
import 'package:go_sport/features/auth/presentation/widgets/guest_timer_bar.dart';
import 'package:go_sport/features/player/presentation/player/mini_player_widget.dart';

class MainShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuest = ref.watch(authProvider) is AuthGuest;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayerWidget(),
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
