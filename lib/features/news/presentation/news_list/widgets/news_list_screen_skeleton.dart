import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_box.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_line.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class NewsListScreenSkeleton extends StatelessWidget {
  const NewsListScreenSkeleton({super.key});

  static const _listPadding = EdgeInsets.only(top: DSSpacing.m, bottom: DSLayout.bottomBarClearance);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const itemHeight = _NewsItemSkeleton.estimatedHeight;
        const separatorHeight = _SeparatorSkeleton.height;

        final availableHeight = math.max(
          0.0,
          constraints.maxHeight - _listPadding.vertical,
        );

        final extentPerRow = itemHeight + separatorHeight;
        final estimatedCount = extentPerRow == 0
            ? 3
            : (availableHeight / extentPerRow).floor().clamp(3, 20);

        return ListView.separated(
          padding: _listPadding,
          itemCount: estimatedCount,
          separatorBuilder: (context, index) => const _SeparatorSkeleton(),
          itemBuilder: (context, index) => const _NewsItemSkeleton(),
        );
      },
    );
  }
}

class _SeparatorSkeleton extends StatelessWidget {
  const _SeparatorSkeleton();

  static const double height = 1;

  @override
  Widget build(BuildContext context) {
    return const SkeletonLine(width: double.infinity, height: height);
  }
}

class _NewsItemSkeleton extends StatelessWidget {
  const _NewsItemSkeleton();

  static const double estimatedHeight = 84 + (8 * 2);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: DSSpacing.s8, horizontal: DSSpacing.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SkeletonBox(width: 84, height: 84, radius: DSRadius.s),
          SizedBox(width: DSSpacing.s12),
          Expanded(
            child: _TitleSkeleton(),
          ),
        ],
      ),
    );
  }
}

class _TitleSkeleton extends StatelessWidget {
  const _TitleSkeleton();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLine(width: constraints.maxWidth),
            SkeletonLine(width: constraints.maxWidth),
            SkeletonLine(width: constraints.maxWidth),
          ],
        );
      },
    );
  }
}
