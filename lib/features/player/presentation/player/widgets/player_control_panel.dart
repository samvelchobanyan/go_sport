import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  const PlayerControlPanel({super.key});

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
            _buildTrackInfo(context, ref, track),

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

  Widget _buildTrackInfo(BuildContext context, WidgetRef ref, track) {
    final imageUrl = track?.imageUrl;
    final title = track?.title ?? '';
    final artist = track?.artistName ?? '';

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

        // Title + Artist
        Expanded(
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

        const SizedBox(width: DSSpacing.s8),

        // Like button
        Consumer(
          builder: (context, ref, _) {
            final isLiked = track == null
                ? false
                : ref.watch(
                    likeRegistryProvider.select((s) =>
                        track.releaseDate != null
                            ? s.likedEpisodes.any((e) => e.id == track.id)
                            : s.likedTracks.any((t) => t.id == track.id)),
                  );
            return GestureDetector(
              onTap: () {
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
                decoration: const BoxDecoration(
                  color: DSColors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: DSHeartIcon(
                    color: DSColors.orange,
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
          onTap: () => ref.read(playerStateProvider.notifier).previous(),
          child: SvgPicture.asset(
            'assets/icons/skip_prev.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              DSColors.blue,
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
          onTap: () => ref.read(playerStateProvider.notifier).next(),
          child: SvgPicture.asset(
            'assets/icons/skip_next.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              DSColors.blue,
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
          onTap: () =>
              ref.read(playerStateProvider.notifier).toggleShuffle(),
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
          onTap: () =>
              ref.read(playerStateProvider.notifier).cycleRepeatMode(),
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
                        border: Border.all(
                          color: DSColors.white,
                          width: 1,
                        ),
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