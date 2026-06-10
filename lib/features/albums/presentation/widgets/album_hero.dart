import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
import 'package:go_sport/domain/entities/album.dart';

class AlbumHero extends StatelessWidget {
  final Album album;
  final bool isLiked;
  final bool isPlaying;
  final VoidCallback onLikeTap;
  final VoidCallback onPlayTap;

  const AlbumHero({
    super.key,
    required this.album,
    required this.isLiked,
    required this.isPlaying,
    required this.onLikeTap,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Hero(
          tag: 'album-image-${album.id}',
          child: Image.network(
            album.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: DSColors.gray40),
          ),
        ),

        // Gradient overlay
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, 0.8),
                DSColors.transparent,
                Color.fromRGBO(0, 0, 0, 0.9),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // Title and buttons
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 44, left: 24, right: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  album.title,
                  style: context.h1?.copyWith(color: DSColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Text(
                  '${album.artist} ${album.releaseYear}',
                  style: context.textL?.copyWith(color: DSColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onLikeTap,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: DSColors.white.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: DSHeartIcon(
                            color: DSColors.white,
                            size: 32,
                            isFilled: isLiked,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onPlayTap,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: DSColors.lime,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            isPlaying
                                ? 'assets/icons/pause.svg'
                                : 'assets/icons/play.svg',
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
