import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/entities/artist.dart';

class ArtistTile extends StatelessWidget {
  final Artist artist;
  final VoidCallback onTap;
  final double topPadding;

  const ArtistTile({
    required this.artist,
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
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: DSNetworkImage(
                  imageUrl: artist.imageUrl,
                  width: 72,
                  height: 72,
                ),
              ),
            ),
            const SizedBox(width: DSSpacing.s12),
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
