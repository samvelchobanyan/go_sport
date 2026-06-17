import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class MusicQuickActionCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MusicQuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DSSpacing.s8),
        decoration: BoxDecoration(
          color: DSColors.white80,
          borderRadius: BorderRadius.circular(DSRadius.s),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: DSSpacing.s8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: context.subtitleMBold),
                const SizedBox(height: DSSpacing.s),
                Text(
                  subtitle,
                  style: context.label?.copyWith(color: DSColors.gray60),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
