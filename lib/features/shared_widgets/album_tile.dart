import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class AlbumTile extends StatelessWidget {
  final String imageUrl;
  final String albumName;
  final String artistName;
  final String releaseYear;
  final VoidCallback onTap;
  final double topPadding;

  const AlbumTile({
    required this.imageUrl,
    required this.albumName,
    required this.artistName,
    required this.releaseYear,
    required this.onTap,
    this.topPadding = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(
          left: DSSpacing.m,
          right: DSSpacing.m,
          top: topPadding,
          bottom: DSSpacing.s8,
        ),
        child: Row(
          children: [
            // Thumbnail image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DSRadius.s),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.s),
                child: DSNetworkImage(
                  imageUrl: imageUrl,
                  width: 72,
                  height: 72,
                ),
              ),
            ),
            const SizedBox(width: DSSpacing.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    albumName,
                    style: context.subtitleMBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: DSSpacing.s),

                  Text(
                    artistName,
                    style: context.textL?.copyWith(color: DSColors.gray60),
                  ),
                  const SizedBox(height: DSSpacing.s),
                  Text(
                    releaseYear,
                    style: context.textL?.copyWith(color: DSColors.gray40),
                  ),
                ],
              ),
            ),
            const SizedBox(width: DSSpacing.s12),

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
