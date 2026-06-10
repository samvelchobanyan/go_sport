import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/shared/widgets/equalizer_indicator.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  final VoidCallback onTap;
  final void Function(Track track) onMenuTap;
  final bool? isPlaying;
  final double topPadding;

  const TrackTile({
    super.key,
    required this.track,
    required this.onTap,
    required this.onMenuTap,
    this.isPlaying,
    this.topPadding = 12,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: topPadding, bottom: 12),
        child: Row(
          children: [
            // Track image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DSRadius.xs),
                boxShadow: [
                  BoxShadow(
                    color: DSColors.gray70,
                    blurRadius: 6,
                    spreadRadius: -2, // prevents shadow from appearing on sides
                    offset: const Offset(0, 4), // pushes shadow down
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.xs),
                child: track.imageUrl != null
                    ? Image.network(
                        track.imageUrl!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 48,
                          height: 48,
                          color: DSColors.gray20,
                        ),
                      )
                    : Container(width: 48, height: 48, color: DSColors.gray20),
              ),
            ),
            const SizedBox(width: 10),

            // Track info
            Expanded(child: _buildTrackContent(context)),

            // Menu button
            GestureDetector(
              onTap: () => onMenuTap(track),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.more_horiz, color: DSColors.gray60, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isPlaying != null) ...[
              EqualizerIndicator(isPlaying: isPlaying!),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                track.title,
                style: context.subtitleM?.copyWith(
                  color: isPlaying != null ? DSColors.blue : DSColors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          track.artistName,
          style: context.textL?.copyWith(color: DSColors.gray60),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
