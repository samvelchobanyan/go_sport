import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          // Using a subtle background with your DS Blue
          color: DSColors.blue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(DSRadius.s),
          border: Border.all(color: DSColors.blue.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: context.subtitleLBold?.copyWith(
                      color: DSColors.blue,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: DSColors.blue),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: context.bodyL?.copyWith(
                color: DSColors.black.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: DSColors.blue.withOpacity(0.1), height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Price',
                  style: context.subtitleM?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  price,
                  style: context.subtitleLBold?.copyWith(color: DSColors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
