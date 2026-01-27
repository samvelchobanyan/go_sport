import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
import 'package:go_sport/domain/entities/playlist.dart';

class PlaylistHero extends StatelessWidget {
  final Playlist playlist;
  final double scrollOffset;
  final VoidCallback onLikeTap;
  final VoidCallback onPlayTap;

  const PlaylistHero({
    super.key,
    required this.playlist,
    required this.scrollOffset,
    required this.onLikeTap,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final heroHeight = screenHeight * 0.5;
    
    // Параллакс: изображение движется на 50% медленнее
    final parallaxOffset = scrollOffset * 0.5;

    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with parallax
          Positioned(
            top: -parallaxOffset,
            left: 0,
            right: 0,
            child: Hero(
              tag: 'playlist-image-${playlist.id}',
              child: Image.network(
                playlist.imageUrl,
                height: heroHeight + 100, // Extra height for parallax
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: heroHeight + 100,
                  color: DSColors.gray40,
                ),
              ),
            ),
          ),
          
          // Gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    DSColors.transparent,
                    DSColors.black.withOpacity(0.3),
                    DSColors.black.withOpacity(0.7),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          
          // Title and buttons
          Positioned(
            left: 24,
            right: 24,
            bottom: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  playlist.title,
                  style: context.h1?.copyWith(color: DSColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Like button
                    GestureDetector(
                      onTap: onLikeTap,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: DSColors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: DSHeartIcon(
                            color: DSColors.white,
                            size: 24,
                            isFilled: playlist.isLiked,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Play button
                    GestureDetector(
                      onTap: onPlayTap,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: DSColors.lime,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow,
                            color: DSColors.black,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
