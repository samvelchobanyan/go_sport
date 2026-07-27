import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/entities/artist.dart';

class ArtistSelectionTile extends StatelessWidget {
  final Artist artist;
  final VoidCallback onTap;

  const ArtistSelectionTile({
    required this.artist,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DSSpacing.m,
          vertical: DSSpacing.s12,
        ),
        child: Row(
          children: [
            // Compact circular image (40x40 instead of 72x72)
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: DSNetworkImage(
                  imageUrl: artist.imageUrl,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            const SizedBox(width: DSSpacing.s12),
            // Artist name
            Expanded(
              child: Text(
                artist.artistName,
                style: context.subtitleM,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: DSSpacing.s12),
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
