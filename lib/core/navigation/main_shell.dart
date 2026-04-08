import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/navigation/widgets/bottom_nav_bar.dart';
import 'package:go_sport/features/player/presentation/player/mini_player_widget.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      // UNCOMMENT LATER
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     const MiniPlayerWidget(),
      //     BottomNavBar(
      //       currentIndex: navigationShell.currentIndex,
      //       onTap: (index) => navigationShell.goBranch(index),
      //     ),
      //   ],
      // ),
    );
  }
}
