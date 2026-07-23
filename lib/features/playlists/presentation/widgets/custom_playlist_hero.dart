import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/domain/entities/playlist.dart';

class CustomPlaylistHero extends StatelessWidget {
  final Playlist playlist;
  final bool isLiked;
  final bool isPlaying;
  final VoidCallback onActionTap;
  final VoidCallback onPlayTap;
  final bool showPlayButton;

  const CustomPlaylistHero({
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
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          'assets/images/custom_playlist_cover.png',
          fit: BoxFit.cover,
        ),

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
                    if (showPlayButton) ...[
                      GestureDetector(
                        onTap: onActionTap,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            // Orange fill only for liked featured playlists. Custom playlists stay translucent.
                            color: DSColors.white.withValues(alpha: 0.25),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/plus.svg',
                              width: 18,
                              height: 18,
                              colorFilter: const ColorFilter.mode(
                                DSColors.lime,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                const SizedBox(height: DSSpacing.m),
                Text(
                  playlist.title,
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
