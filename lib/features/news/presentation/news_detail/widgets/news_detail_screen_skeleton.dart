import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_box.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_circle.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_line.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class NewsDetailScreenSkeleton extends StatelessWidget {
  const NewsDetailScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DSColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DSColors.black),
          onPressed: () => context.pop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: _AuthorSkeleton(),
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),

            // Image
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: _ImageSkeleton(),
            ),
            SizedBox(height: 14),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: _TitleSkeleton(),
            ),
            SizedBox(height: 15),

            // Subtitle quote
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: _QuoteSkeleton(),
            ),
            SizedBox(height: 15),

            // Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: _ContentSkeleton(),
            ),
            SizedBox(height: 16),

            // Divider (replaces DottedDivider)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SkeletonLine(width: double.infinity, height: 1),
            ),
            SizedBox(height: 16),

            // Bottom actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: _BottomActionsSkeleton(),
            ),
            SizedBox(height: 21),
          ],
        ),
      ),
    );
  }
}

class _AuthorSkeleton extends StatelessWidget {
  const _AuthorSkeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: SkeletonBox(
            width: 14,
            height: 2,
            radius: DSRadius.xs,
          ),
        ),
        const SizedBox(width: 2),
        const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SkeletonLine(width: 44),
            SkeletonLine(width: 64),
          ],
        ),
      ],
    );
  }
}

class _ImageSkeleton extends StatelessWidget {
  const _ImageSkeleton();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SkeletonBox(
          width: constraints.maxWidth,
          height: 240,
          radius: DSRadius.s,
        );
      },
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLine(width: constraints.maxWidth),
            SkeletonLine(width: constraints.maxWidth),
          ],
        );
      },
    );
  }
}

class _QuoteSkeleton extends StatelessWidget {
  const _QuoteSkeleton();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: DSColors.blue,
            width: 3,
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: _QuoteLinesSkeleton(),
      ),
    );
  }
}

class _QuoteLinesSkeleton extends StatelessWidget {
  const _QuoteLinesSkeleton();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLine(width: constraints.maxWidth),
            SkeletonLine(width: constraints.maxWidth),
          ],
        );
      },
    );
  }
}

class _ContentSkeleton extends StatelessWidget {
  const _ContentSkeleton();

  static const int _lineCount = 10;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            _lineCount,
            (index) => SkeletonLine(width: constraints.maxWidth),
          ),
        );
      },
    );
  }
}

class _BottomActionsSkeleton extends StatelessWidget {
  const _BottomActionsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SkeletonCircle(size: 48),
        const SizedBox(width: 16),
        const SkeletonCircle(size: 48),
        const Spacer(),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: DSColors.divider, width: 1),
            borderRadius: BorderRadius.circular(DSRadius.l),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                SkeletonCircle(size: 16),
                SizedBox(width: 6),
                SkeletonLine(width: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
