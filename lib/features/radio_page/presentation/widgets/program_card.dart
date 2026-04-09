import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/shared_widgets/count_badge.dart';
import 'package:go_sport/features/shared_widgets/media_card_shell.dart';

class ProgramCard extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int episodeCount;

  const ProgramCard({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.episodeCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/music/program/$id'),
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaCardShell(
              child: Hero(
                tag: 'program-image-$id',
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: DSColors.gray20),
                  errorWidget: (context, url, error) =>
                      Container(color: DSColors.gray20),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: context.subtitleM,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            CountBadge(count: episodeCount, type: CountBadgeType.programs),
          ],
        ),
      ),
    );
  }
}
