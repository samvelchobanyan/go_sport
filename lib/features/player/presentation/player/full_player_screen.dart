import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'widgets/player_top_bar.dart';

class FullPlayerScreen extends ConsumerWidget {
  const FullPlayerScreen({super.key});

  /// Opens the full player as a modal bottom sheet.
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: DSColors.transparent,
      barrierColor: DSColors.black.withOpacity(0.5),
      enableDrag: true,
      builder: (context) => const FullPlayerScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: DSColors.transparent,
      body: Stack(
        children: [
          // Background gradient (edge-to-edge, behind status bar)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  DSColors.blue.withOpacity(0.08),
                  DSColors.blue.withOpacity(0.15),
                ],
              ),
            ),
          ),

          // Content (respects safe area)
          SafeArea(
            child: Column(
              children: [
                const PlayerTopBar(),
                const Expanded(
                  child: SizedBox(), // TODO: PlayerArtworkCarousel
                ),
                // TODO: PlayerControlPanel (with SeekBar inside)
              ],
            ),
          ),
        ],
      ),
    );
  }
}