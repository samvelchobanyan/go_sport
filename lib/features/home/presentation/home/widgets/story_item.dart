import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/story.dart';

class StoryItem extends StatelessWidget {
  final Story story;
  final VoidCallback onTap;

  const StoryItem({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: !story.isViewed
              ? const SweepGradient(
                  colors: DSColors.storyGradient,
                  stops: [0.0, 0.5, 1.0],
                )
              : null,
          // border: story.isViewed
          //     ? Border.all(color: DSColors.divider, width: 2)
          //     : null,
          color: story.isViewed ? DSColors.divider : null,
        ),
        child: Container(
          padding: EdgeInsets.all(3), // толщина белого кольца
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DSColors.white,
          ),
          child: Center(
            child: SizedBox(
              width: 62, // 72 - 2*(outerRing 2 + whiteRing 3) = 62
              height: 62,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: story.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: DSColors.grey20,
                    child: const Icon(
                      Icons.person,
                      color: DSColors.grey50,
                      size: 28,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: DSColors.grey20,
                    child: const Icon(
                      Icons.error,
                      color: DSColors.grey50,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
