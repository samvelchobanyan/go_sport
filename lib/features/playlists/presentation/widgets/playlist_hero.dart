import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
import 'package:go_sport/domain/entities/playlist.dart';

class PlaylistHero extends StatelessWidget {
  final Playlist playlist;
  final bool isLiked;
  final bool isPlaying;
  final VoidCallback onActionTap;
  final VoidCallback onPlayTap;
  final bool showPlayButton;

  const PlaylistHero({
    super.key,
    required this.playlist,
    required this.isLiked,
    required this.isPlaying,
    required this.onActionTap,
    required this.onPlayTap,
    this.showPlayButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final isCustom = playlist.type == PlaylistType.custom;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        isCustom
            ? Image.asset(
                'assets/images/custom_playlist_cover.png',
                fit: BoxFit.cover,
              )
            : Image.network(
                playlist.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: DSColors.gray40),
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
            padding: const EdgeInsets.only(bottom: DSLayout.heroContentBottom, left: DSSpacing.l, right: DSSpacing.l),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  playlist.title,
                  style: context.h1?.copyWith(color: DSColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: DSSpacing.l),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Action button
                    GestureDetector(
                      onTap: onActionTap,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: DSColors.white.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCustom
                              ? SvgPicture.asset(
                                  'assets/icons/plus.svg',
                                  width: 18,
                                  height: 18,
                                  colorFilter: const ColorFilter.mode(
                                    DSColors.lime,
                                    BlendMode.srcIn,
                                  ),
                                )
                              : DSHeartIcon(
                                  color: DSColors.white,
                                  size: DSIconSize.s32,
                                  isFilled: isLiked,
                                ),
                        ),
                      ),
                    ),
                    if (showPlayButton) ...[
                      const SizedBox(width: DSSpacing.m),
                      // Play button
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
