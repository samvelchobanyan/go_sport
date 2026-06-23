import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';

class AddTrackTile extends StatelessWidget {
  final Track track;
  final bool isSelected;
  final VoidCallback onToggle;
  final double topPadding;

  /// Когда трек уже в плейлисте — тап игнорируется (трек показывается
  /// с галочкой как выбранный, но «снять» его здесь нельзя).
  final bool enabled;

  const AddTrackTile({
    super.key,
    required this.track,
    required this.isSelected,
    required this.onToggle,
    this.topPadding = 8,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: DSSpacing.m, right: DSSpacing.m, top: topPadding, bottom: DSSpacing.s8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(DSRadius.xs),
            child: DSNetworkImage(
              imageUrl: track.imageUrl,
              width: 48,
              height: 48,
            ),
          ),
          const SizedBox(width: DSSpacing.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: context.subtitleM,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: DSSpacing.xs),
                Text(
                  track.artistName,
                  style: context.textL?.copyWith(color: DSColors.gray60),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: DSSpacing.s12),
          GestureDetector(
            onTap: enabled ? onToggle : null,
            child: SvgPicture.asset(
              isSelected
                  ? 'assets/icons/added.svg'
                  : 'assets/icons/add.svg',
              width: 32,
              height: 32,
            ),
          ),
        ],
      ),
    );
  }
}
