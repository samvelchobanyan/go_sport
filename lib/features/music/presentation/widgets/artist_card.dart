import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';

class ArtistCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const ArtistCard({
    required this.name,
    required this.imageUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(width: 120, height: 120, color: DSColors.divider),
              errorWidget: (context, url, error) => Container(
                width: 120,
                height: 120,
                color: DSColors.gray20,
                child: const Icon(
                  Icons.error,
                  color: DSColors.gray50,
                  size: DSIconSize.s28,
                ),
              ),
            ),
          ),
          const SizedBox(height: DSSpacing.s12),
          SizedBox(
            width: 120,
            child: Text(
              name,
              style: context.subtitleM,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
