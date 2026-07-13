import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/banner.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PodcastBanner extends StatelessWidget {
  final HeroBanner? banner;

  const PodcastBanner({super.key, this.banner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
      child: GestureDetector(
        onTap: () async {
          final url = banner?.redirectUrl;
          if (url == null || url.isEmpty) return;

          // if the link is an external web link
          if (url.startsWith('http://') || url.startsWith('https://')) {
            try {
              // Open in default external system browser
              await launchUrlString(url, mode: LaunchMode.externalApplication);
            } catch (e) {
              debugPrint('Could not launch external URL: $url — Error: $e');
            }
          } else {
            // if it's nested
            context.push(url);
          }
        },
        child: AspectRatio(
          aspectRatio: 329 / 169,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DSRadius.m),
              boxShadow: [
                BoxShadow(
                  color: DSColors.black.withValues(alpha: 0.15),
                  offset: const Offset(0, 6),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DSRadius.m),
              child: DSNetworkImage(
                imageUrl: banner?.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
