import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';

class AddTrackTile extends StatelessWidget {
  final Track track;
  final bool isSelected;
  final VoidCallback onToggle;

  const AddTrackTile({
    super.key,
    required this.track,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(DSRadius.xs),
            child: CachedNetworkImage(
              imageUrl: track.imageUrl ?? '',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(width: 48, height: 48, color: DSColors.divider),
              errorWidget: (context, url, error) => Container(
                width: 48,
                height: 48,
                color: DSColors.gray20,
                child: const Icon(Icons.music_note, color: DSColors.gray50),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 4),
                Text(
                  track.artistName,
                  style: context.textL?.copyWith(color: DSColors.gray60),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onToggle,
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
