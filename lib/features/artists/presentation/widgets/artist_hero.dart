import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/artist.dart';

class ArtistHero extends StatelessWidget {
  final Artist artist;
  final bool isLiked;
  final VoidCallback onLikeTap;

  const ArtistHero({
    super.key,
    required this.artist,
    required this.isLiked,
    required this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          artist.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(color: DSColors.gray40),
        ),

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

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 44, left: 24, right: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                const SizedBox(height: 16),
                Text(
                  artist.artistName,
                  style: context.h1?.copyWith(color: DSColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
