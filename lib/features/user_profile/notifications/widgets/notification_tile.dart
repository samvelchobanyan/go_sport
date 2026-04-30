import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: DSColors.black.withOpacity(0.15),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.s),
                child: Image.asset(
                  imagePath,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 52,
                    height: 52,
                    color: DSColors.blue.withOpacity(0.1),
                    child: const Icon(
                      Icons.notifications,
                      color: DSColors.blue,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Text Content
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.subtitleM,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: context.textL?.copyWith(color: DSColors.gray60),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                color: DSColors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
                color: DSColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
