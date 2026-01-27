import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'media_card_shell.dart';
import 'count_badge.dart';

class PlaylistCard extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int trackCount;
  final VoidCallback onTap;

  const PlaylistCard({
    super.key,
    required this.id,
    required this.title,
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
                  errorBuilder: (_, __, ___) => Container(color: DSColors.gray20),
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
            const SizedBox(height: 6),
            CountBadge(
              count: trackCount,
              type: CountBadgeType.tracks,
            ),
          ],
        ),
      ),
    );
  }
}