import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
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
        color: DSColors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DSRadius.l),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
          vertical: DSSpacing.m,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Track info row
            _buildTrackInfo(context, track),

            const SizedBox(height: 25),

            const PlayerSeekBar(),
            const SizedBox(height: 40),

            // Playback controls
            _buildControls(context, ref, info.isPlaying, info.status),

            const Spacer(),

            // Shuffle & Repeat
            _buildBottomActions(
              context,
              ref,
              shuffleEnabled: info.shuffleEnabled,
              repeatMode: info.repeatMode,
            ),

            const SizedBox(height: 16),

            // Bottom safe area padding
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackInfo(BuildContext context, track) {
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
            child: imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(
                      color: DSColors.gray20,
                      child: const Icon(Icons.music_note, color: DSColors.gray50),
                    ),
                  )
                : Container(
                    color: DSColors.gray20,
                    child: const Icon(Icons.music_note, color: DSColors.gray50),
                  ),
          ),
        ),

        const SizedBox(width: 8),

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

        const SizedBox(width: 8),

        // Like button
        GestureDetector(
          onTap: () {
            // TODO: wire like action
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: DSColors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: DSHeartIcon(
                color: DSColors.orange,
                size: 38,
                isFilled: false,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControls(
    BuildContext context,
    WidgetRef ref,
    bool isPlaying,
    PlayerStatus status,
  ) {
    final isLoading = status == PlayerStatus.loading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous
        GestureDetector(
          onTap: () => ref.read(playerStateProvider.notifier).previous(),
          child: SvgPicture.asset(
            'assets/icons/skip_prev.svg',
            width: 32,
            height: 32,
            colorFilter: const ColorFilter.mode(
              DSColors.blue,
              BlendMode.srcIn,
            ),
          ),
        ),

        // Play / Pause (large circular button)
        GestureDetector(
          onTap: () => ref.read(playerStateProvider.notifier).togglePlayPause(),
          child: Container(
            width: 72,
            height: 72,
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
                      isPlaying
                          ? 'assets/icons/pause.svg'
                          : 'assets/icons/play.svg',
                      width: 32,
                      height: 32,
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
            width: 32,
            height: 32,
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
              width: 24,
              height: 24,
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
                  width: 24,
                  height: 24,
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