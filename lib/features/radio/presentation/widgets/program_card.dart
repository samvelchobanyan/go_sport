import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/features/shared_widgets/count_badge.dart';
import 'package:go_sport/features/shared_widgets/media_card_shell.dart';

class ProgramCard extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int episodeCount;
  final VoidCallback onTap;

  const ProgramCard({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.episodeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 152,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaCardShell(
              child: Hero(
                tag: 'program-image-$id',
                child: DSNetworkImage(imageUrl: imageUrl),
              ),
            ),
            const SizedBox(height: DSSpacing.s6),
            Text(
              title,
              style: context.subtitleM,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: DSSpacing.s6),
            CountBadge(count: episodeCount, type: CountBadgeType.programs),
          ],
        ),
      ),
    );
  }
}
