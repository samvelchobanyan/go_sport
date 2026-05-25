import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class ProgramTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int episodeCount;
  final VoidCallback onTap;

  const ProgramTile({
    required this.imageUrl,
    required this.title,
    required this.episodeCount,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Thumbnail image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: DSColors.gray70,
                    blurRadius: 6,
                    spreadRadius: -2, // reduces shadow spread on sides
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.s),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(width: 50, height: 50, color: DSColors.divider),
                  errorWidget: (context, url, error) => Container(
                    width: 50,
                    height: 50,
                    color: DSColors.gray20,
                    child: const Icon(
                      Icons.error,
                      color: DSColors.gray50,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Title and episode count badge
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
                  const SizedBox(height: 4),
                  // Episode count badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: DSColors.blue5,
                      borderRadius: BorderRadius.circular(DSRadius.m),
                      border: Border.all(color: DSColors.blue30),
                    ),
                    child: Text(
                      '$episodeCount episode${episodeCount != 1 ? 's' : ''}',
                      style: context.fieldLabel?.copyWith(color: DSColors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
