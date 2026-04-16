import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/playlist.dart';

class PlaylistTile extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final int trackCount;
  final PlaylistType type;

  const PlaylistTile({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.trackCount,
    this.type = PlaylistType.featured,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '/music/playlist/$id?type=${type.name}',
        extra: Playlist(
          id: id,
          title: title,
          imageUrl: imageUrl,
          trackCount: trackCount,
          type: type,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Thumbnail image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: DSColors.black.withOpacity(0.7),
                    blurRadius: 6,
                    spreadRadius: -2, // reduces shadow spread on sides
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DSRadius.s),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
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
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Title and episode count badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: context.subtitleM,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Episode count badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: DSColors.orange.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(DSRadius.m),
                      border: Border.all(
                        color: DSColors.orange.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      '$trackCount track${trackCount != 1 ? 's' : ''}',
                      style: context.fieldLabel?.copyWith(
                        color: DSColors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

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
