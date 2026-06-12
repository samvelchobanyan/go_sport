import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/domain/state/player_state_selectors.dart';

class PlayerSeekBar extends ConsumerStatefulWidget {
  const PlayerSeekBar({super.key});

  @override
  ConsumerState<PlayerSeekBar> createState() => _PlayerSeekBarState();
}

class _PlayerSeekBarState extends ConsumerState<PlayerSeekBar> {
  /// Current slider position (0.0–1.0).
  /// Always holds a value — either from drag or from stream.
  double _dragValue = 0.0;

  /// True while user is dragging the thumb.
  /// While true, stream updates are ignored.
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final seekBar = ref.watch(playerSeekBarProvider);

    final durationMs = seekBar.duration.inMilliseconds.toDouble();
    final positionMs = seekBar.position.inMilliseconds.toDouble();
    final bufferedMs = seekBar.bufferedPosition.inMilliseconds.toDouble();

    final streamValue = durationMs > 0
        ? positionMs.clamp(0.0, durationMs) / durationMs
        : 0.0;
    final secondaryValue = durationMs > 0
        ? bufferedMs.clamp(0.0, durationMs) / durationMs
        : 0.0;

    // Update local value from stream only when not dragging
    if (!_isDragging) {
      _dragValue = streamValue;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 2.0,
            activeTrackColor: DSColors.blue,
            inactiveTrackColor: DSColors.blue.withValues(alpha: 0.2),
            secondaryActiveTrackColor: DSColors.blue.withValues(alpha: 0.5),
            thumbShape: const _RoundedRectThumbShape(
              width: 6.0,
              height: 14.0,
              radius: 3.0,
            ),
            thumbColor: DSColors.blue,
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
            overlayColor: DSColors.blue.withValues(alpha: 0.12),
            trackShape: const _FullWidthTrackShape(),
          ),
          child: Slider(
            value: _dragValue,
            secondaryTrackValue: secondaryValue,
            onChangeStart: seekBar.canSeek
                ? (v) => setState(() {
                      _isDragging = true;
                      _dragValue = v;
                    })
                : null,
            onChanged: seekBar.canSeek
                ? (v) => setState(() => _dragValue = v)
                : null,
            onChangeEnd: seekBar.canSeek
                ? (v) {
                    final newPosition = Duration(
                      milliseconds: (v * durationMs).round(),
                    );
                    ref.read(playerStateProvider.notifier).seek(newPosition);
                    setState(() => _isDragging = false);
                  }
                : null,
          ),
        ),
        const SizedBox(height: DSSpacing.s8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(
                Duration(
                  milliseconds: (_dragValue * durationMs).round(),
                ),
              ),
              style: context.textL?.copyWith(color: DSColors.black),
            ),
            Text(
              _formatDuration(seekBar.duration),
              style: context.textL?.copyWith(color: DSColors.black),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (d.inHours > 0) {
      final hours = d.inHours.toString().padLeft(2, '0');
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }
}

// === Custom Track Shape (full width, no overlay padding) ===

class _FullWidthTrackShape extends RoundedRectSliderTrackShape {
  const _FullWidthTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 2.0;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

// === Custom Thumb Shape ===

class _RoundedRectThumbShape extends SliderComponentShape {
  final double width;
  final double height;
  final double radius;

  const _RoundedRectThumbShape({
    required this.width,
    required this.height,
    required this.radius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(width, height);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: width, height: height),
      Radius.circular(radius),
    );

    // Fill
    final fillPaint = Paint()
      ..color = sliderTheme.thumbColor ?? DSColors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rect, fillPaint);

    // Border
    final borderPaint = Paint()
      ..color = DSColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(rect, borderPaint);
  }
}
