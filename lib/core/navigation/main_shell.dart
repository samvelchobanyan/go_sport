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
          MiniPlayerWidget(
            onOpenFullPlayer: () => FullPlayerScreen.show(context),
            onOpenRadioPlayer: () => RadioFullPlayerScreen.show(context),
          ),
          BottomNavBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
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
