import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:flutter/services.dart'; 
import 'widgets/player_top_bar.dart';
import 'widgets/player_control_panel.dart';
import 'widgets/player_fluid_background.dart';
import 'widgets/player_artwork_carousel.dart';

class FullPlayerScreen extends ConsumerStatefulWidget {
  const FullPlayerScreen({super.key});

  /// Opens the full player as a modal bottom sheet.
  static void show(BuildContext context) {
    final view = View.of(context);
    final mq = MediaQueryData.fromView(view);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: DSColors.transparent,
      barrierColor: DSColors.gray30,
      enableDrag: true,
      builder: (_) => MediaQuery(
        data: mq,
        child: const FullPlayerScreen(),
      ),
      // builder: (context) => const FullPlayerScreen(),
    );
  }

  @override
  ConsumerState<FullPlayerScreen> createState() => _FullPlayerScreenState();
}

class _FullPlayerScreenState extends ConsumerState<FullPlayerScreen> {
  // Shared between the artwork carousel and the prev/next buttons so both drive
  // the same PageView. Created lazily (viewport fraction needs the screen width)
  // and disposed here — this screen is the single owner of the controller.
  PageController? _pageController;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    _pageController ??= PageController(
      initialPage: 1,
      viewportFraction: PlayerArtworkCarousel.viewportFractionFor(screenWidth),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.transparent,
        body: Stack(
          children: [
            Container(color: DSColors.white),
            const PlayerFluidBackground(scale: 1.7, opacity: 0.65),
      
            // Content (respects safe area)
            SafeArea(
              child: Column(
                children: [
                  const PlayerTopBar(),
                  Expanded(
                    child: PlayerArtworkCarousel(controller: _pageController!),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: PlayerControlPanel(controller: _pageController!),
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