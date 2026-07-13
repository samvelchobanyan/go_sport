import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imagePath;
  final VoidCallback onTap;
  final bool isSeen;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.imagePath,
    required this.isSeen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: DSSpacing.s8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(DSRadius.s),
              child: DSNetworkImage(imageUrl: imagePath, width: 52, height: 52),
            ),

            const SizedBox(width: DSSpacing.s14),

            // Title
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: context.subtitleM,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!isSeen) ...[
                        const SizedBox(width: DSSpacing.xs),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: DSColors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: DSSpacing.xs),
                  Text(
                    subtitle,
                    style: context.textL?.copyWith(color: DSColors.gray60),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: DSSpacing.s8),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: DSSpacing.s6,
                horizontal: DSSpacing.s8,
              ),
              decoration: BoxDecoration(
                color: DSColors.blue10,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
                color: DSColors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
