import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(136, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: DSIconSize.s24,
                  color: DSColors.black,
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
                  colors: [DSColors.transparent, DSColors.gray80],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      GestureDetector(
                        onTap: () =>
                            onAction(story.ctaTargetType, story.ctaTargetId),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: DSColors.lime,
                            borderRadius: BorderRadius.circular(DSRadius.xxl),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/volume.svg'),
                              const SizedBox(width: DSSpacing.s8),
                              Text(
                                story.ctaLabel,
                                style: context.subtitleLBold?.copyWith(
                                  color: DSColors.blue,
                                ),
                              ),
                            ],
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
