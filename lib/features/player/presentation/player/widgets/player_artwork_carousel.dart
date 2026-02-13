import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  int _currentPage = 0;
  bool _isUserSwiping = false;

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
    final pageWidth = cardWidth + _gap;
    return pageWidth / screenWidth;
  }

  void _initPageController(double screenWidth, int initialIndex) {
    final viewportFraction = _calculateViewportFraction(screenWidth);
    _pageController?.dispose();
    _pageController = PageController(
      initialPage: initialIndex,
      viewportFraction: viewportFraction,
    );
    _currentPage = initialIndex;
  }

  void _onPageChanged(int index) {
    if (_currentPage == index) return;
    _currentPage = index;

    if (_isUserSwiping) {
      // User swiped - trigger track change
      ref.read(playerStateProvider.notifier).skipTo(index);
    }
  }

  void _syncToStateIndex(int stateIndex) {
    if (_pageController == null || !_pageController!.hasClients) return;
    if (_currentPage == stateIndex) return;
    if (_isUserSwiping) return;

    _currentPage = stateIndex;
    _pageController!.animateToPage(
      stateIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tracks =
        ref.watch(playerStateProvider.select((s) => s.tracks));
    final currentIndex =
        ref.watch(playerStateProvider.select((s) => s.currentIndex));

    // Empty queue
    if (tracks.isEmpty) {
      return const SizedBox();
    }

    final screenWidth = MediaQuery.of(context).size.width;

    // Initialize or sync page controller
    if (_pageController == null) {
      _initPageController(screenWidth, currentIndex);
    } else {
      // Sync carousel to state (e.g., when next/prev buttons pressed)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _syncToStateIndex(currentIndex);
      });
    }

    final cardWidth = screenWidth - _horizontalPadding * 2;

    return SizedBox(
      height: _centerHeight,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            if (notification.dragDetails != null) {
              _isUserSwiping = true;
            }
          } else if (notification is ScrollEndNotification) {
            _isUserSwiping = false;
          }
          return false;
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: tracks.length,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController!,
              builder: (context, child) {
                double pageOffset = 0;
                if (_pageController!.position.hasContentDimensions) {
                  pageOffset = (_pageController!.page ?? _currentPage.toDouble()) - index;
                }

                // Calculate scale based on distance from center
                // Center card: scale = 1.0 (height = 264)
                // Side cards: scale = 204/264 ≈ 0.773
                final distance = pageOffset.abs().clamp(0.0, 1.0);
                final heightScale = 1.0 - (distance * (1.0 - _sideHeight / _centerHeight));
                final currentHeight = _centerHeight * heightScale;
                
                // Shadow opacity: only visible on center card
                final shadowOpacity = (1.0 - distance).clamp(0.0, 1.0);

                return Center(
                  child: SizedBox(
                    width: cardWidth,
                    height: currentHeight,
                    child: _ArtworkCard(
                      imageUrl: tracks[index].imageUrl,
                      shadowOpacity: shadowOpacity,
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

  final String imageUrl;
  final double shadowOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DSRadius.m),
        boxShadow: shadowOpacity > 0
            ? [
                BoxShadow(
                  color: DSColors.gray50.withOpacity(0.25 * shadowOpacity),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                  spreadRadius: -2,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DSRadius.m),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          memCacheWidth: 300,
          memCacheHeight: 300,
          placeholder: (context, url) => Container(
            color: DSColors.gray20,
          ),
          errorWidget: (context, url, error) => Container(
            color: DSColors.gray20,
            child: const Icon(
              Icons.music_note,
              size: 48,
              color: DSColors.gray50,
            ),
          ),
        ),
      ),
    );
  }
}