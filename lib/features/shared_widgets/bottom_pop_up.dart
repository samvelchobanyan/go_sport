import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

void showItemOptionsBottomSheet({
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
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: DSColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
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
                _ActionButton(
                  icon: 'assets/icons/plus.svg',
                  label: 'Add to playlist',
                  onTap: () {
                    Navigator.pop(context);
                    debugPrint('Add to playlist tapped');
                  },
                ),
                const SizedBox(height: 10),

                // Like
                _ActionButton(
                  icon: 'assets/icons/heart_bg.svg',
                  label: 'Liked',
                  onTap: () {
                    Navigator.pop(context);
                    debugPrint('Like tapped');
                  },
                ),
                const SizedBox(height: 10),

                // Share
                _ActionButton(
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

class _ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 32, height: 32),
          const SizedBox(width: 10),
          Text(
            label,
            style: context.subtitleMBold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
