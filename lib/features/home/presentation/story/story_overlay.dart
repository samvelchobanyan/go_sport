import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
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
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: story.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: DSColors.gray20,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
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

          // Close button (top-right)
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: DSSpacing.m,
                  top: DSSpacing.m,
                ),
                child: GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: DSColors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: DSColors.black,
                    ),
                  ),
                ),
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
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DSSpacing.l,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),

                      // Title
                      Text(
                        story.title,
                        style: context.h2?.copyWith(
                          color: DSColors.white,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Description
                      Text(
                        story.text,
                        style: context.bodyL?.copyWith(
                          color: DSColors.white.withOpacity(0.85),
                        ),
                      ),

                      const SizedBox(height: DSSpacing.l),

                      // CTA Button
                      GestureDetector(
                        onTap: () => onAction(story.ctaTargetType, story.ctaTargetId),
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: DSColors.lime,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.campaign,
                                size: 20,
                                color: DSColors.black,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                story.ctaLabel,
                                style: context.subtitleLBold?.copyWith(
                                  color: DSColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + DSSpacing.l,
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
