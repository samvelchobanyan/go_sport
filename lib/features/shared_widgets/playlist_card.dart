import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'media_card_shell.dart';
import 'count_badge.dart';
import 'package:go_router/go_router.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '/music/playlist/${playlist.id}?type=${playlist.type.name}',
        extra: playlist,
      ),
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaCardShell(
              child: DSNetworkImage(imageUrl: playlist.imageUrl),
            ),
            const SizedBox(height: DSSpacing.s6),
            Text(
              playlist.title,
              style: context.subtitleLSemi,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: DSSpacing.s6),
            CountBadge(count: playlist.trackCount, type: CountBadgeType.tracks),
          ],
        ),
      ),
    );
  }
}
