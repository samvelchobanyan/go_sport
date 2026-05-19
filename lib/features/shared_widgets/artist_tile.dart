import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/artist.dart';

class ArtistTile extends StatelessWidget {
  final Artist artist;

  const ArtistTile({required this.artist, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/music/artist/${artist.id}', extra: artist),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: DSColors.gray70,
                    blurRadius: 6,
                    spreadRadius: -2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: artist.imageUrl,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(width: 72, height: 72, color: DSColors.divider),
                  errorWidget: (context, url, error) => Container(
                    width: 72,
                    height: 72,
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
            Expanded(
              child: SizedBox(
                width: 120,
                child: Text(
                  artist.artistName,
                  style: context.subtitleM,
                  maxLines: 2,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
