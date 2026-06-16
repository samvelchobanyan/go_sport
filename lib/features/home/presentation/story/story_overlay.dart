import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/domain/entities/story.dart';

class StoryOverlay extends StatelessWidget {
  const StoryOverlay({
    super.key,
    required this.story,
    required this.onClose,
    required this.onAction,
  });

  final Story story;
  final VoidCallback onClose;
  final void Function(String targetType, String targetId) onAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSColors.transparent,
      body: Stack(
        children: [
          // Background image (full screen, including system areas)
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: story.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: DSColors.gray20,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: DSColors.gray20,
                child: Icon(
                  Icons.broken_image,
                  size: 64,
                  color: DSColors.gray50,
                ),
              ),
            ),
          ),

          // Close button (top-right, respecting safe area)
          Positioned(
            top: MediaQuery.of(context).padding.top + DSSpacing.m,
            right: DSSpacing.m,
            child: GestureDetector(
              onTap: onClose,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: DSColors.white90,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, size: DSIconSize.s24, color: DSColors.black),
              ),
            ),
          ),

          // Bottom content area with gradient
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [DSColors.transparent, DSColors.gray80],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),

                      // Title
                      Text(
                        story.title,
                        style: context.h2?.copyWith(color: DSColors.white),
                      ),

                      const SizedBox(height: DSSpacing.s10),

                      // Description
                      Text(
                        story.text,
                        style: context.bodyL?.copyWith(color: DSColors.white80),
                      ),

                      const SizedBox(height: DSSpacing.l),

                      // CTA Button
                      Padding(
                        padding: const EdgeInsets.all(DSSpacing.l),
                        child: SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () => onAction(
                              story.ctaTargetType,
                              story.ctaTargetId,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                color: DSColors.lime,
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xxl,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.campaign,
                                    size: DSIconSize.s20,
                                    color: DSColors.black,
                                  ),
                                  const SizedBox(width: DSSpacing.s8),
                                  Text(
                                    story.ctaLabel,
                                    style: context.subtitleLBold?.copyWith(
                                      color: DSColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                            MediaQuery.of(context).padding.bottom + DSSpacing.l,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
