import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/playlist.dart';

class PlaylistTile extends StatelessWidget {
  final Playlist playlist;
  final double topPadding;

  const PlaylistTile({
    required this.playlist,
    this.topPadding = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '/music/playlist/${playlist.id}?type=${playlist.type.name}',
        extra: playlist,
      ),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(left: DSSpacing.m, right: DSSpacing.m, top: topPadding, bottom: DSSpacing.s8),
        child: Row(
          children: [
            // Thumbnail image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DSRadius.s),
                boxShadow: [
                  BoxShadow(
                    color: DSColors.gray70,
                    blurRadius: 6,
                    spreadRadius: -2, // reduces shadow spread on sides
                    offset: const Offset(0, 4),
                  ),
                ],
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
                    : CachedNetworkImage(
                        imageUrl: playlist.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(width: 50, height: 50, color: DSColors.divider),
                        errorWidget: (context, url, error) => Container(
                          width: 50,
                          height: 50,
                          color: DSColors.gray20,
                          child: const Icon(
                            Icons.error,
                            color: DSColors.gray50,
                            size: DSIconSize.s28,
                          ),
                        ),
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
