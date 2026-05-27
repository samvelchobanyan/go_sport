import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/features/playlists/presentation/bottom_sheets/add_to_playlist_bottom_sheet.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/track_options.dart';
import 'package:go_sport/features/shared_widgets/track_number_badge.dart';
import 'package:go_sport/shared/widgets/equalizer_indicator.dart';

class AlbumTrackTile extends StatelessWidget {
  final Track track;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;
  final bool? isPlaying;

  const AlbumTrackTile({
    super.key,
    required this.track,
    required this.index,
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
            TrackNumberBadge(index: index),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
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
            ),
            GestureDetector(
              onTap: () {
                onMenuTap();
                showTrackOptionsBottomSheet(
                  context: context,
                  imageUrl: track.imageUrl ?? '',
                  title: track.title,
                  subtitle: track.artistName,
                  onAddToPlaylist: () => showAddToPlaylistBottomSheet(
                    context: context,
                    track: track,
                  ),
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
}
