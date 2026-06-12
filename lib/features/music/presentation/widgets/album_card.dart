import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/features/shared_widgets/media_card_shell.dart';
import 'package:go_sport/features/shared_widgets/count_badge.dart';

class AlbumCard extends StatelessWidget {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final int trackCount;
  final VoidCallback onTap;

  const AlbumCard({
    super.key,
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.trackCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaCardShell(
              child: Hero(
                tag: 'album-image-$id',
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(width: 84, height: 84, color: DSColors.divider),
                  errorWidget: (context, url, error) => Container(
                    color: DSColors.gray20,
                    child: const Icon(
                      Icons.error,
                      color: DSColors.gray50,
                      size: DSIconSize.s28,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: DSSpacing.s6),
            Text(
              title,
              style: context.subtitleM,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: DSSpacing.xs),
            Text(
              artist,
              style: context.bodyL?.copyWith(color: DSColors.gray60),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: DSSpacing.s6),
            CountBadge(count: trackCount, type: CountBadgeType.tracks),
          ],
        ),
      ),
    );
  }
}
