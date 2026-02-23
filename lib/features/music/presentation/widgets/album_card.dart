import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
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
                tag: 'playlist-image-$id',
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: DSColors.gray20),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: context.subtitleM,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              artist,
              style: context.bodyL?.copyWith(color: DSColors.gray60),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            CountBadge(count: trackCount, type: CountBadgeType.tracks),
          ],
        ),
      ),
    );
  }
}
