import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/domain/state/player_state_selectors.dart';

import 'player_seek_bar.dart';

class PlayerControlPanel extends ConsumerWidget {
  const PlayerControlPanel({super.key, required this.controller});

  /// The carousel's page controller. Prev/Next animate this instead of moving
  /// the track directly — the track advances at the end of the slide, via the
  /// carousel's own ScrollEndNotification handler (same path as a swipe).
  final PageController controller;

  static const Duration _kSwipeDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(playerInfoProvider);
    final track = info.track;

    return Container(
      decoration: BoxDecoration(
        color: DSColors.white50,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DSRadius.l),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
          vertical: DSSpacing.s36,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Track info row
            _buildTrackInfo(context, ref, track, info.displayImageUrl),

            const SizedBox(height: DSSpacing.s8),

            const PlayerSeekBar(),
            const SizedBox(height: DSSpacing.s40),

            // Playback controls
            _buildControls(
              context,
              ref,
              info.isPlaying,
              info.status,
              info.isRadioMode,
              info.canGoPrev,
              info.canGoNext,
            ),

            const Spacer(),

            // Shuffle & Repeat
            _buildBottomActions(
              context,
              ref,
              shuffleEnabled: info.shuffleEnabled,
              repeatMode: info.repeatMode,
            ),

            const SizedBox(height: DSSpacing.m),

            // Bottom safe area padding
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackInfo(
    BuildContext context,
    WidgetRef ref,
    track,
    String? imageUrl,
  ) {
    final title = track?.title ?? '';
    final artist = track?.artistName ?? '';
    final authState = ref.watch(authProvider);

    // Disable interactions if the user is a guest or unauthorized
    final isGuest = authState is! AuthAuthenticated;
    return Row(
      children: [
        // Small album art
        ClipRRect(
          borderRadius: BorderRadius.circular(DSRadius.xs),
          child: SizedBox(
            width: 45,
            height: 45,
            child: DSNetworkImage(imageUrl: imageUrl),
          ),
        ),

        const SizedBox(width: DSSpacing.s8),

        // Title + Artist — tap opens the artist page (when we know the id)
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              final artistId = track?.artistId;
              if (artistId == null) return;
              context.push('/music/artist/$artistId');
              Navigator.of(context).pop(); // close the full-player sheet
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.subtitleLBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (artist.isNotEmpty) ...[
                  const SizedBox(height: DSSpacing.s),
                  Text(
                    artist,
                    style: context.bodyL?.copyWith(color: DSColors.gray60),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(width: DSSpacing.s8),

        // Like button
        Consumer(
          builder: (context, ref, _) {
            final isLiked = track == null
                ? false
                : ref.watch(
                    likeRegistryProvider.select(
                      (s) => track.releaseDate != null
                          ? s.likedEpisodes.any((e) => e.id == track.id)
                          : s.likedTracks.any((t) => t.id == track.id),
                    ),
                  );
            return GestureDetector(
              onTap: isGuest
                  ? null
                  : () {
                      if (track == null) return;
                      final registry = ref.read(likeRegistryProvider.notifier);
                      if (track.releaseDate != null) {
                        registry.toggleEpisodeLike(track);
                      } else {
                        registry.toggleTrackLike(track);
                      }
                    },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isLiked ? DSColors.orange : DSColors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: DSHeartIcon(
                    color: isLiked ? DSColors.white : DSColors.orange,
                    size: DSIconSize.s28,
                    isFilled: isLiked,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildControls(
    BuildContext context,
    WidgetRef ref,
    bool isPlaying,
    PlayerStatus status,
    bool isRadioMode,
    bool canGoPrev,
    bool canGoNext,
  ) {
    // Scope the button visuals to music: while radio is the active source the
    // music track isn't actually playing, so show Play (not Pause) and no spinner.
    final isMusicPlaying = !isRadioMode && isPlaying;
    final isLoading = !isRadioMode && status == PlayerStatus.loading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous
        GestureDetector(
          onTap: canGoPrev
              ? () => controller.animateToPage(
                  0,
                  duration: _kSwipeDuration,
                  curve: Curves.easeOut,
                )
              : null,
          child: SvgPicture.asset(
            'assets/icons/skip_prev.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              canGoPrev ? DSColors.blue : DSColors.gray40,
              BlendMode.srcIn,
            ),
          ),
        ),

        // Play / Pause (large circular button)
        GestureDetector(
          onTap: () {
            final notifier = ref.read(playerStateProvider.notifier);
            if (isRadioMode) {
              // Music player is open while radio is the active source — Play
              // means "come back to my track", not "resume the radio stream".
              notifier.resumeMusic();
            } else {
              notifier.togglePlayPause();
            }
          },
          child: Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              color: DSColors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        color: DSColors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : SvgPicture.asset(
                      isMusicPlaying
                          ? 'assets/icons/pause.svg'
                          : 'assets/icons/play.svg',
                      width: 53,
                      height: 53,
                      colorFilter: const ColorFilter.mode(
                        DSColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
            ),
          ),
        ),

        // Next
        GestureDetector(
          onTap: canGoNext
              ? () => controller.animateToPage(
                  2,
                  duration: _kSwipeDuration,
                  curve: Curves.easeOut,
                )
              : null,
          child: SvgPicture.asset(
            'assets/icons/skip_next.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              canGoNext ? DSColors.blue : DSColors.gray40,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(
    BuildContext context,
    WidgetRef ref, {
    required bool shuffleEnabled,
    required RepeatMode repeatMode,
  }) {
    final repeatActive = repeatMode != RepeatMode.off;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Shuffle
        GestureDetector(
          onTap: () => ref.read(playerStateProvider.notifier).toggleShuffle(),
          child: Opacity(
            opacity: shuffleEnabled ? 1.0 : 0.4,
            child: SvgPicture.asset(
              'assets/icons/shuffle.svg',
              width: 28,
              height: 28,
              colorFilter: const ColorFilter.mode(
                DSColors.blue,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),

        // Repeat
        GestureDetector(
          onTap: () => ref.read(playerStateProvider.notifier).cycleRepeatMode(),
          child: Opacity(
            opacity: repeatActive ? 1.0 : 0.4,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  'assets/icons/repeat.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    DSColors.blue,
                    BlendMode.srcIn,
                  ),
                ),
                if (repeatMode == RepeatMode.one)
                  Positioned(
                    right: -1,
                    bottom: -1,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: DSColors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: DSColors.white, width: 1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
