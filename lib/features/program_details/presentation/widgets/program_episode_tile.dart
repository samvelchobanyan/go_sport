import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/track_options.dart';
import 'package:go_sport/features/shared_widgets/track_number_badge.dart';
import 'package:go_sport/shared/widgets/equalizer_indicator.dart';

class ProgramEpisodeTile extends StatelessWidget {
  final Track episode;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;
  final bool? isPlaying;
  final double topPadding;
  final Program? program;

  const ProgramEpisodeTile({
    super.key,
    required this.episode,
    required this.index,
    required this.onTap,
    required this.onMenuTap,
    this.isPlaying,
    this.topPadding = 8,
    this.program,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: DSSpacing.m,
          right: DSSpacing.m,
          top: topPadding,
          bottom: DSSpacing.s8,
        ),
        child: Row(
          children: [
            TrackNumberBadge(index: index),
            const SizedBox(width: DSSpacing.s10),
            Expanded(child: _buildEpisodeContent(context)),
            GestureDetector(
              onTap: () {
                onMenuTap();
                showTrackOptionsBottomSheet(
                  context: context,
                  track: episode,
                  programId: program?.id,
                  program: program,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.all(DSSpacing.s8),
                child: Icon(
                  Icons.more_horiz,
                  color: DSColors.gray60,
                  size: DSIconSize.s24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEpisodeContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isPlaying != null) ...[
              EqualizerIndicator(isPlaying: isPlaying!),
              const SizedBox(width: DSSpacing.s8),
            ],
            Expanded(
              child: Text(
                episode.title,
                style: context.subtitleM?.copyWith(
                  color: isPlaying != null ? DSColors.blue : DSColors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: DSSpacing.s),
        Row(
          children: [
            if (episode.releaseDate != null)
              Text(
                _formatDate(episode.releaseDate),
                style: context.textL?.copyWith(color: DSColors.gray60),
              ),
            Text(' • ', style: context.textL?.copyWith(color: DSColors.gray60)),
            Text(
              _formatDuration(episode.duration),
              style: context.textL?.copyWith(color: DSColors.gray60),
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
