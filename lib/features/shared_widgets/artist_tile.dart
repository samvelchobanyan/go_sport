import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

class ArtistTile extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ArtistTile({required this.name, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        //todo redirect to artist page
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: DSColors.black.withOpacity(0.7),
                    blurRadius: 6,
                    spreadRadius: -2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
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
                child: Text(name, style: context.subtitleM, maxLines: 2),
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
