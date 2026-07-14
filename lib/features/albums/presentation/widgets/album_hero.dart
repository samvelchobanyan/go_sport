import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/features/shared_widgets/hero_like_button.dart';

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
        DSNetworkImage(imageUrl: album.imageUrl),

        // Gradient overlay
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, 1.0),
                DSColors.transparent,
                Color.fromRGBO(0, 0, 0, 1.0),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // Title and buttons
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: DSLayout.heroContentBottom,
              left: DSSpacing.l,
              right: DSSpacing.l,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeroLikeButton(isLiked: isLiked, onActionTap: onLikeTap),

                    const SizedBox(width: DSSpacing.m),
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
                const SizedBox(height: DSSpacing.m),
                Text(
                  '${album.artist} • ${album.releaseYear}',
                  style: context.textL?.copyWith(color: DSColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: DSSpacing.s12),
                Text(
                  album.title,
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
