import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/track_options.dart';
import 'package:go_sport/shared/widgets/equalizer_indicator.dart';

class EpisodeTile extends StatelessWidget {
  final Track episode;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;
  final bool? isPlaying;

  const EpisodeTile({
    super.key,
    required this.episode,
    required this.onTap,
    required this.onMenuTap,
    this.isPlaying,
  });

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // episode image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DSRadius.xs),
                boxShadow: [
                  BoxShadow(
                    color: DSColors.black.withOpacity(0.7),
                    blurRadius: 6,
                    spreadRadius: -2, // prevents shadow from appearing on sides
                    offset: const Offset(0, 4), // pushes shadow down
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.xs),
                child: episode.imageUrl != null
                    ? Image.network(
                        episode.imageUrl!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(width: 48, height: 48, color: DSColors.gray20),
                      )
                    : Container(width: 48, height: 48, color: DSColors.gray20),
              ),
            ),
            const SizedBox(width: 10),

            // Track info
            Expanded(child: _buildEpisodeContent(context)),

            // Menu button
            GestureDetector(
              onTap: () {
                onMenuTap(); //in case something different should happen
                showTrackOptionsBottomSheet(
                  context: context,
                  imageUrl: episode.imageUrl ?? '',
                  title: episode.title,
                  subtitle: episode.artistName,
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

  Widget _buildEpisodeContent(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.title,
                    style: context.subtitleM?.copyWith(
                      color: isPlaying != null ? DSColors.blue : DSColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (episode.releaseDate != null)
                        Text(
                          _formatDate(episode.releaseDate),
                          style: context.subtitleLSemi?.copyWith(
                            color: DSColors.gray60,
                          ),
                        ),
                      Text(
                        ' • ',
                        style: context.subtitleLSemi?.copyWith(
                          color: DSColors.gray60,
                        ),
                      ),
                      Text(
                        _formatDuration(episode.duration),
                        style: context.subtitleLSemi?.copyWith(
                          color: DSColors.gray60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
