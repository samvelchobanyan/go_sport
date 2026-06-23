import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
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
    this.topPadding = 8,
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
            // Track image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DSRadius.xs),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.xs),
                child: DSNetworkImage(
                  imageUrl: track.imageUrl,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
            const SizedBox(width: DSSpacing.s10),

            // Track info
            Expanded(child: _buildTrackContent(context)),

            // Menu button
            GestureDetector(
              onTap: () => onMenuTap(track),
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
              const SizedBox(width: DSSpacing.s8),
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
        const SizedBox(height: DSSpacing.s),
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
