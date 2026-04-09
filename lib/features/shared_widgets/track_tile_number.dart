import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/track_options.dart';
import 'package:go_sport/shared/widgets/equalizer_indicator.dart';

class TrackTileNumber extends StatelessWidget {
  final Track track;
  final String number;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;
  final bool? isPlaying;

  const TrackTileNumber({
    super.key,
    required this.track,
    required this.number,
    required this.onTap,
    required this.onMenuTap,
    this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Track image
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(DSRadius.s),
            //   ),
            //   child:
            Container(
              decoration: BoxDecoration(
                color: DSColors.blue.withOpacity(0.07),
                borderRadius: BorderRadius.circular(DSRadius.s),
              ),
              height: 32,
              width: 32,
              child: Center(
                child: Text(
                  number,
                  style: context.subtitleMBold?.copyWith(color: DSColors.blue),
                ),
              ),
              // ),
            ),
            const SizedBox(width: 10),

            // Track info
            Expanded(child: _buildTrackContent(context)),

            // Menu button
            GestureDetector(
              onTap: () {
                onMenuTap();
                // todo change this sheet
                showTrackOptionsBottomSheet(
                  context: context,
                  imageUrl: track.imageUrl ?? '',
                  title: track.title,
                  subtitle: track.artistName,
                );
              },
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
        Row(
          children: [
            if (track.releaseDate != null)
              Text(
                _formatDate(track.releaseDate),
                style: context.subtitleLSemi?.copyWith(color: DSColors.gray60),
              ),
            Text(
              ' • ',
              style: context.subtitleLSemi?.copyWith(color: DSColors.gray60),
            ),
            Text(
              _formatDuration(track.duration),
              style: context.subtitleLSemi?.copyWith(color: DSColors.gray60),
            ),
          ],
        ),
      ],
    );
  }
}

String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

String _formatDate(DateTime? date) {
  if (date == null) return '';
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inDays == 0) {
    return 'Today';
  } else if (diff.inDays == 1) {
    return 'Yesterday';
  } else if (diff.inDays < 7) {
    return '${diff.inDays}d ago';
  } else if (diff.inDays < 30) {
    return '${(diff.inDays / 7).floor()}w ago';
  } else {
    return '${(diff.inDays / 30).floor()}m ago';
  }
}
