import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/track_options.dart';
import 'package:go_sport/features/playlists/presentation/bottom_sheets/add_to_playlist_bottom_sheet.dart';
import 'package:go_sport/shared/widgets/equalizer_indicator.dart';

class EpisodeTile extends StatelessWidget {
  final Track episode;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;
  final bool? isPlaying;
  final double topPadding;

  const EpisodeTile({
    super.key,
    required this.episode,
    required this.onTap,
    required this.onMenuTap,
    this.isPlaying,
    this.topPadding = 8,
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
        padding: EdgeInsets.only(
          left: DSSpacing.m,
          right: DSSpacing.m,
          top: topPadding,
          bottom: DSSpacing.s8,
        ),
        child: SizedBox(
          height: 52,
          child: Row(
            children: [
              // episode image
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DSRadius.xs),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(DSRadius.xs),
                  child: episode.imageUrl != null
                      ? Image.network(
                          episode.imageUrl!,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 48,
                            height: 48,
                            color: DSColors.gray20,
                          ),
                        )
                      : Container(
                          width: 48,
                          height: 48,
                          color: DSColors.gray20,
                        ),
                ),
              ),
              const SizedBox(width: DSSpacing.s10),

              // Track info
              Expanded(child: _buildEpisodeContent(context)),

              // Menu button
              GestureDetector(
                onTap: () {
                  onMenuTap(); //in case something different should happen
                  showTrackOptionsBottomSheet(
                    context: context,
                    track: episode,
                    onAddToPlaylist: () => showAddToPlaylistBottomSheet(
                      context: context,
                      track: episode,
                    ),
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(DSSpacing.s8),
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
                  const SizedBox(height: DSSpacing.xs),
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
