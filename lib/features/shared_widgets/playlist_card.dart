import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
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
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaCardShell(
              child: Hero(
                tag: 'playlist-image-${playlist.id}',
                child: Image.network(
                  playlist.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: DSColors.gray20),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              playlist.title,
              style: context.subtitleM,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            CountBadge(count: playlist.trackCount, type: CountBadgeType.tracks),
          ],
        ),
      ),
    );
  }
}
