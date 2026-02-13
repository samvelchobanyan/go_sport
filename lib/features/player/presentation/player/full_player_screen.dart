import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'widgets/player_top_bar.dart';
import 'widgets/animated_gradient.dart';
import 'widgets/player_control_panel.dart';
import 'widgets/player_fluid_background.dart';

class FullPlayerScreen extends ConsumerWidget {
  const FullPlayerScreen({super.key});

  /// Opens the full player as a modal bottom sheet.
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: DSColors.transparent,
      barrierColor: DSColors.black.withOpacity(0.3),
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
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [
          //         const Color(0xFFF3F4FF),
          //         const Color(0xFFE8EAFF),
          //       ],
          //     ),
          //   ),
          // ),
          // const AnimatedGradientBlobs(),
          // PlayerFluidBackground(
          //   colors: [
          //     // Объект 1 (Фиолетовые тона)
          //     const Color(0xFF404AC3), const Color(0xFF441BBF),
          //     // Объект 2 (Сине-голубые)
          //     const Color(0xFF404AC3), const Color(0xFFF15E22),
          //     // Объект 3 (Розово-красные)
          //     const Color(0xFFDC2828), const Color(0xFFF15E22),
          //     // Объект 4 (Глубокие индиго)
          //     const Color(0xFF2870DC), const Color(0xFFEBD300),
          //     // Объект 5 (Маджента)
          //     const Color(0xFF2870DC), const Color(0xFFDC2828),
          //     // Объект 6 (Бирюза/Мята)
          //     const Color(0xFFEBD300), const Color(0xFF2870DC),
          //   ],
          // ),
          const PlayerFluidBackground(scale: 1.7, opacity: 0.9),

          // Content (respects safe area)
          SafeArea(
            child: Column(
              children: [
                const PlayerTopBar(),
                const Expanded(
                  child: SizedBox(), // TODO: PlayerArtworkCarousel
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: const PlayerControlPanel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}