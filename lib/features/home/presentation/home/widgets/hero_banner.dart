import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class PodcastBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const PodcastBanner({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
      child: GestureDetector(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 329 / 169,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DSRadius.m),
              image: const DecorationImage(
                image: AssetImage('assets/images/podcast_banner.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: DSColors.black.withValues(alpha: 0.15),
                  offset: const Offset(0, 6),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(DSSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New\nepisode',
                    style: context.h1?.copyWith(
                          color: DSColors.lime,
                        ),
                  ),
                  const SizedBox(height: DSSpacing.s20),
                  Text(
                    'Sportcast',
                    style: context.subtitleLSemi?.copyWith(
                      color: DSColors.white,
                    ),
                  ),
                  const SizedBox(height: DSSpacing.s12),
                  // Кнопка Listen now
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: DSColors.black,
                      borderRadius: BorderRadius.circular(DSRadius.l),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.play_circle,
                          color: DSColors.white,
                          size: DSIconSize.s20,
                        ),
                        const SizedBox(width: DSSpacing.s8),
                        Text(
                          'Listen now',
                          style: context.subtitleLSemi?.copyWith(
                            color: DSColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}