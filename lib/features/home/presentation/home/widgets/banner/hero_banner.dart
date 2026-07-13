import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class PodcastBanner extends StatelessWidget {
  final VoidCallback? onTap;
  final String? imageUrl;
  final String? redirectUrl;

  const PodcastBanner({super.key, this.imageUrl, this.redirectUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool hasNetworkImage = imageUrl != null && imageUrl!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
      child: GestureDetector(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 329 / 169,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DSRadius.m),
              image: const DecorationImage(
                image: AssetImage('assets/images/podcast_banner.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: DSColors.black.withValues(alpha: 0.15),
                  offset: const Offset(0, 6),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Positioned.fill(
              child: hasNetworkImage
                  ? DSNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover)
                  : Image.asset(
                      'assets/images/podcast_banner.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
