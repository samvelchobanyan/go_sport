import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:flutter/services.dart'; 
import 'widgets/player_top_bar.dart';
import 'widgets/animated_gradient.dart';
import 'widgets/player_control_panel.dart';
import 'widgets/player_fluid_background.dart';
import 'widgets/player_artwork_carousel.dart';

class FullPlayerScreen extends ConsumerWidget {
  const FullPlayerScreen({super.key});

  /// Opens the full player as a modal bottom sheet.
  static void show(BuildContext context) {
    final view = View.of(context);
    final mq = MediaQueryData.fromView(view);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: false,
      backgroundColor: DSColors.transparent,
      barrierColor: DSColors.black.withValues(alpha: 0.3),
      enableDrag: true,
      builder: (_) => MediaQuery(
        data: mq,
        child: const FullPlayerScreen(),
      ),
      // builder: (context) => const FullPlayerScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.transparent,
        body: Stack(
          children: [
            Container(color: Colors.white),
            const PlayerFluidBackground(scale: 1.7, opacity: 0.65),
      
            // Content (respects safe area)
            SafeArea(
              child: Column(
                children: [
                  const PlayerTopBar(),
                  const Expanded(
                    child: PlayerArtworkCarousel(),
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
      ),
    );
  }
}