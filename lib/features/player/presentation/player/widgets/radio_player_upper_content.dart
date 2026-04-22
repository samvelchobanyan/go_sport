import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/domain/state/current_program_state.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/domain/state/player_state_selectors.dart';

class RadioPlayerUpperContent extends ConsumerWidget {
  const RadioPlayerUpperContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(playerInfoProvider);
    final isRadioPlaying = info.isRadioMode && info.isPlaying;
    final isLoading =
        info.isRadioMode && info.status == PlayerStatus.loading;

    final currentProgram = ref.watch(currentProgramProvider);
    final nowPlaying = _parseNowPlaying(info.radioNowPlaying);
    final cardImageUrl = info.radioImageUrl ?? currentProgram?.imageUrl;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
      child: Column(
        children: [
          const Spacer(),
          _PlayButton(
            isPlaying: isRadioPlaying,
            isLoading: isLoading,
            onTap: () {
              final notifier = ref.read(playerStateProvider.notifier);
              if (info.isRadioMode) {
                notifier.togglePlayPause();
              } else {
                notifier.playRadio();
              }
            },
          ),
          const Spacer(),
          Text(
            'Playing live now',
            style: context.textL?.copyWith(color: DSColors.gray60),
          ),
          const SizedBox(height: DSSpacing.xs),
          Text(
            currentProgram?.title ?? '—',
            style: context.h2?.copyWith(color: DSColors.black),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          _NowPlayingCard(
            imageUrl: cardImageUrl,
            title: nowPlaying.title,
            artist: nowPlaying.artist,
          ),
          const SizedBox(height: 8),
          _ProgramTimers(program: currentProgram),
          const Spacer(),
        ],
      ),
    );
  }

  ({String title, String artist}) _parseNowPlaying(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return (title: 'Live broadcast', artist: '');
    }
    final parts = raw.split(' - ');
    if (parts.length >= 2) {
      return (
        title: parts.sublist(1).join(' - ').trim(),
        artist: parts.first.trim(),
      );
    }
    return (title: raw.trim(), artist: '');
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.isPlaying,
    required this.isLoading,
    required this.onTap,
  });

  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    color: DSColors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : SvgPicture.asset(
                  isPlaying
                      ? 'assets/icons/pause.svg'
                      : 'assets/icons/play.svg',
                  width: 36,
                  height: 36,
                  colorFilter: const ColorFilter.mode(
                    DSColors.white,
                    BlendMode.srcIn,
                  ),
                ),
        ),
      ),
    );
  }
}

class _NowPlayingCard extends StatelessWidget {
  const _NowPlayingCard({
    required this.imageUrl,
    required this.title,
    required this.artist,
  });

  final String? imageUrl;
  final String title;
  final String artist;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: DSColors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(DSRadius.s),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(DSRadius.xs),
            child: SizedBox(
              width: 36,
              height: 36,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(
                        color: DSColors.gray20,
                        child: const Icon(
                          Icons.radio,
                          color: DSColors.gray50,
                        ),
                      ),
                    )
                  : Container(
                      color: DSColors.gray20,
                      child: const Icon(Icons.radio, color: DSColors.gray50),
                    ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.subtitleLBold?.copyWith(color: DSColors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (artist.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    artist,
                    style: context.textL?.copyWith(color: DSColors.gray60),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgramTimers extends ConsumerWidget {
  const _ProgramTimers({required this.program});

  final ScheduledProgram? program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(nowTickerProvider).value ?? DateTime.now();

    final p = program;
    final startedLabel = p != null ? _formatClock(p.startDate) : '--:--';
    final willFinishLabel = p != null ? _formatClock(p.endDate) : '--:--';
    final remaining = p != null
        ? p.endDate.difference(now)
        : Duration.zero;
    final remainingLabel =
        p != null && !remaining.isNegative ? _formatDuration(remaining) : '--:--';

    return Row(
      children: [
        Expanded(child: _TimeBox(label: 'Started', value: startedLabel)),
        const SizedBox(width: DSSpacing.xs + 4),
        Expanded(child: _TimeBox(label: 'Remaining', value: remainingLabel)),
        const SizedBox(width: DSSpacing.xs + 4),
        Expanded(child: _TimeBox(label: 'Will Finish', value: willFinishLabel)),
      ],
    );
  }

  String _formatClock(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _formatDuration(Duration d) {
    final totalSeconds = d.inSeconds;
    final mm = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final ss = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }
}

class _TimeBox extends StatelessWidget {
  const _TimeBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: DSColors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(DSRadius.s),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.textL?.copyWith(color: DSColors.blue),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: context.subtitleM?.copyWith(color: DSColors.black),
          ),
        ],
      ),
    );
  }
}
