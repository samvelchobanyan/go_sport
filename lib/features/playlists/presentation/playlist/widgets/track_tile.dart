import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;
  final bool isPlaying;

  const TrackTile({
    super.key,
    required this.track,
    required this.onTap,
    required this.onMenuTap,
    this.isPlaying = false,
  });

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            // Track image
            ClipRRect(
              borderRadius: BorderRadius.circular(DSRadius.xs),
              child: Image.network(
                track.imageUrl,
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
            const SizedBox(width: 12),
            
            // Track info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.title,
                    style: context.subtitleM?.copyWith(
                      color: isPlaying ? DSColors.blue : DSColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    track.artistName,
                    style: context.textL?.copyWith(color: DSColors.gray60),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Menu button
            GestureDetector(
              onTap: onMenuTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_horiz,
                  color: DSColors.gray60,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
