import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/player_state.dart';

class PlayerArtworkCarousel extends ConsumerStatefulWidget {
  const PlayerArtworkCarousel({super.key});

  @override
  ConsumerState<PlayerArtworkCarousel> createState() =>
      _PlayerArtworkCarouselState();
}

class _PlayerArtworkCarouselState extends ConsumerState<PlayerArtworkCarousel> {
  PageController? _pageController;
  static const double _horizontalPadding = 48.0;
  static const double _gap = 32.0;
  static const double _centerHeight = 264.0;
  static const double _sideHeight = 204.0;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  double _calculateViewportFraction(double screenWidth) {
    final cardWidth = screenWidth - _horizontalPadding * 2;
    return (cardWidth + _gap) / screenWidth;
  }

  void _onScrollEnd() {
    final page = _pageController?.page?.round();
    if (page == null || page == 1) return;

    if (page == 2) {
      ref.read(playerStateProvider.notifier).next();
    } else if (page == 0) {
      ref.read(playerStateProvider.notifier).previous();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && (_pageController?.hasClients ?? false)) {
        _pageController!.jumpToPage(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTrack =
        ref.watch(playerStateProvider.select((s) => s.currentTrack));
    final prevTrack =
        ref.watch(playerStateProvider.select((s) => s.prevTrack));
    final nextTrack =
        ref.watch(playerStateProvider.select((s) => s.nextTrack));

    if (currentTrack == null) return const SizedBox();

    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth - _horizontalPadding * 2;

    _pageController ??= PageController(
      initialPage: 1,
      viewportFraction: _calculateViewportFraction(screenWidth),
    );

    return SizedBox(
      height: _centerHeight,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          _onScrollEnd();
          return false;
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: 3,
          physics: const PageScrollPhysics(),
          itemBuilder: (context, index) {
            final track = switch (index) {
              0 => prevTrack,
              1 => currentTrack,
              2 => nextTrack,
              _ => null,
            };

            return AnimatedBuilder(
              animation: _pageController!,
              builder: (context, child) {
                double pageOffset = 0;
                if (_pageController!.position.hasContentDimensions) {
                  pageOffset = (_pageController!.page ?? 1.0) - index;
                }

                final distance = pageOffset.abs().clamp(0.0, 1.0);
                final heightScale =
                    1.0 - (distance * (1.0 - _sideHeight / _centerHeight));
                final currentHeight = _centerHeight * heightScale;
                final shadowOpacity = (1.0 - distance).clamp(0.0, 1.0);

                return Center(
                  child: SizedBox(
                    width: cardWidth,
                    height: currentHeight,
                    child: _ArtworkCard(
                      imageUrl: track?.imageUrl,
                      shadowOpacity: track != null ? shadowOpacity : 0,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ArtworkCard extends StatelessWidget {
  const _ArtworkCard({
    required this.imageUrl,
    required this.shadowOpacity,
  });

  final String? imageUrl;
  final double shadowOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DSRadius.m),
        boxShadow: shadowOpacity > 0
            ? [
                BoxShadow(
                  color: DSColors.gray50.withValues(alpha: 0.25 * shadowOpacity),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                  spreadRadius: -2,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DSRadius.m),
        child: DSNetworkImage(
          imageUrl: imageUrl,
          memCacheWidth: 300,
          memCacheHeight: 300,
        ),
      ),
    );
  }
}
