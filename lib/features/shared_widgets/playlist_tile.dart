import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/playlist.dart';

class PlaylistTile extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;
  final double topPadding;

  const PlaylistTile({
    required this.playlist,
    required this.onTap,
    this.topPadding = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(
          left: DSSpacing.m,
          right: DSSpacing.m,
          top: topPadding,
          bottom: DSSpacing.s8,
        ),
        child: Row(
          children: [
            // Thumbnail image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DSRadius.s),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.s),
                child: playlist.type == PlaylistType.custom
                    ? Image.asset(
                        playlist.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : DSNetworkImage(
                        imageUrl: playlist.imageUrl,
                        width: 50,
                        height: 50,
                      ),
              ),
            ),
            const SizedBox(width: DSSpacing.s12),
            // Title and episode count badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    playlist.title,
                    style: context.subtitleM,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: DSSpacing.xs),
                  // Episode count badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: DSColors.orange5,
                      borderRadius: BorderRadius.circular(DSRadius.m),
                      border: Border.all(color: DSColors.orange30),
                    ),
                    child: Text(
                      '${playlist.trackCount} track${playlist.trackCount != 1 ? 's' : ''}',
                      style: context.fieldLabel?.copyWith(
                        color: DSColors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: DSSpacing.s12),

            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
