import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';

const double _kSegmentHeight = 3.0;
const double _kSegmentGap = DSSpacing.xs;
const double _kSegmentRadius = 2.0;

/// Segmented progress indicator for the story viewer (Instagram-style).
///
/// Dumb widget: given the total [count], the [currentIndex] and the [progress]
/// (0..1) of the current segment, it just paints. Segments before the current
/// one are full, the current one is filled by [progress], the rest are empty.
class StoryProgressBar extends StatelessWidget {
  const StoryProgressBar({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.progress,
  });

  final int count;
  final int currentIndex;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final double value = i < currentIndex
            ? 1.0
            : i == currentIndex
                ? progress.clamp(0.0, 1.0)
                : 0.0;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: i == count - 1 ? 0 : _kSegmentGap,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_kSegmentRadius),
              child: LinearProgressIndicator(
                value: value,
                minHeight: _kSegmentHeight,
                backgroundColor: DSColors.white50,
                valueColor: const AlwaysStoppedAnimation(DSColors.white),
              ),
            ),
          ),
        );
      }),
    );
  }
}
