import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/action_button.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

void showTrackOptionsBottomSheet({
  required BuildContext context,
  required String imageUrl,
  required String title,
  String? subtitle,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        color: DSColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DSRadius.l),
          topRight: Radius.circular(DSRadius.l),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Album info
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DSRadius.xs),
                    boxShadow: [
                      BoxShadow(
                        color: DSColors.black.withOpacity(0.7),
                        blurRadius: 6,
                        spreadRadius:
                            -2, // prevents shadow from appearing on sides
                        offset: const Offset(0, 4), // pushes shadow down
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(DSRadius.xs),
                    child: Image.network(
                      imageUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 48,
                        height: 48,
                        color: DSColors.gray20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: context.subtitleM,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: context.textL?.copyWith(
                            color: DSColors.gray60,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DottedDivider(color: DSColors.gray20),
            const SizedBox(height: 10),
            // Action buttons
            Column(
              children: [
                // Add to playlist
                ActionButton(
                  icon: 'assets/icons/plus_bg.svg',
                  label: 'Add to playlist',
                  onTap: () {
                    Navigator.pop(context);
                    debugPrint('Add to playlist tapped');
                  },
                ),
                const SizedBox(height: 10),

                // Like
                ActionButton(
                  icon: 'assets/icons/heart_bg.svg',
                  label: 'Liked',
                  onTap: () {
                    Navigator.pop(context);
                    debugPrint('Like tapped');
                  },
                ),
                const SizedBox(height: 10),

                // Share
                ActionButton(
                  icon: 'assets/icons/share.svg',
                  label: 'Share',
                  onTap: () {
                    Navigator.pop(context);
                    debugPrint('Share tapped');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
