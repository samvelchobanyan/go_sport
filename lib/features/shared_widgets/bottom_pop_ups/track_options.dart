import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/action_button.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/bottom_sheet_container.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

void showTrackOptionsBottomSheet({
  required BuildContext context,
  required Track track,
  VoidCallback? onRemoveFromPlaylist,
  VoidCallback? onAddToPlaylist,
}) {
  final albumId = track.albumId;
  final programId = track.programId;

  // 💡 Check if a valid redirect target exists
  final hasRedirection =
      (programId != null && programId.isNotEmpty) ||
      (albumId != null && albumId.isNotEmpty);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => BottomSheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Track info
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: !hasRedirection
                ? null
                : () {
                    // Capture the router before closing the sheet — the sheet's own
                    // context is unmounted after pop.
                    final router = GoRouter.of(context);
                    final currentPath = router.state.uri.path;
                    final isAlreadyThere =
                        (programId != null &&
                            currentPath.contains('/program/$programId')) ||
                        (albumId != null &&
                            currentPath.contains('/album/$albumId'));

                    Navigator.of(context, rootNavigator: true).pop();
                    if (isAlreadyThere) return;

                    if (programId != null && programId.isNotEmpty) {
                      router.push('/music/program/$programId');
                    } else if (albumId != null && albumId.isNotEmpty) {
                      router.push('/music/album/$albumId');
                    }
                  },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DSRadius.xs),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(DSRadius.xs),
                    child: DSNetworkImage(
                      imageUrl: track.imageUrl,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                const SizedBox(width: DSSpacing.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        track.title,
                        style: context.subtitleM,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (track.artistName.isNotEmpty) ...[
                        const SizedBox(height: DSSpacing.xs),
                        Text(
                          track.artistName,
                          style: context.textL?.copyWith(
                            color: DSColors.gray60,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (hasRedirection)
                  SvgPicture.asset(
                    'assets/icons/arrow_right.svg',
                    width: 20,
                    height: 20,
                  ),
              ],
            ),
          ),
          const SizedBox(height: DSSpacing.s10),
          DottedDivider(color: DSColors.gray20),
          const SizedBox(height: DSSpacing.s10),
          // Action buttons
          Column(
            children: [
              // Add to playlist — only when the caller provides the callback
              // (episode tiles don't: episodes can't be added to playlists).
              if (onAddToPlaylist != null) ...[
                ActionButton(
                  icon: 'assets/icons/plus_bg.svg',
                  label: onRemoveFromPlaylist != null
                      ? 'Add to another playlist'
                      : 'Add to playlist',
                  onTap: () {
                    Navigator.pop(context);
                    onAddToPlaylist();
                  },
                ),
                const SizedBox(height: DSSpacing.s10),
              ],

              // Like
              Consumer(
                builder: (context, ref, _) {
                  final isEpisode = track.releaseDate != null;
                  final isLiked = ref.watch(
                    likeRegistryProvider.select(
                      (s) => isEpisode
                          ? s.likedEpisodes.any((e) => e.id == track.id)
                          : s.likedTracks.any((t) => t.id == track.id),
                    ),
                  );
                  return ActionButton(
                    icon: isLiked
                        ? 'assets/icons/heart_bg_darker.svg'
                        : 'assets/icons/heart_bg_stroke.svg',
                    label: isLiked ? 'Liked' : 'Like',
                    onTap: () {
                      final registry = ref.read(likeRegistryProvider.notifier);
                      if (isEpisode) {
                        registry.toggleEpisodeLike(track);
                      } else {
                        registry.toggleTrackLike(track);
                      }
                      // Navigator.pop(context);
                    },
                  );
                },
              ),

              // Remove from this playlist
              if (onRemoveFromPlaylist != null) ...[
                const SizedBox(height: DSSpacing.s10),
                ActionButton(
                  icon: 'assets/icons/delete_bg.svg',
                  label: 'Remove from this playlist',
                  onTap: () {
                    Navigator.pop(context);
                    onRemoveFromPlaylist();
                  },
                ),
              ],
              // const SizedBox(height: DSSpacing.s10),

              // Share — functionality not implemented yet, hidden for now.
              // ActionButton(
              //   icon: 'assets/icons/share.svg',
              //   label: 'Share',
              //   onTap: () {
              //     Navigator.pop(context);
              //     debugPrint('Share tapped');
              //   },
              // ),
            ],
          ),
        ],
      ),
    ),
  );
}
