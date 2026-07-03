import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_box.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_circle.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_line.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: const [
        _StoriesRowSkeletonSliver(),
        _PodcastBannerSkeletonSliver(),
        _FeaturedPlaylistsHeaderSkeletonSliver(),
        _FeaturedPlaylistsCarouselSkeletonSliver(),
        _NewsHeaderSkeletonSliver(),
        _NewsListSkeletonSliver(),
      ],
    );
  }
}

class _StoriesRowSkeletonSliver extends StatelessWidget {
  const _StoriesRowSkeletonSliver();

  static const double _storySize = 72;
  static const double _storyGap = 8;

  @override
  Widget build(BuildContext context) {
    final count = 7;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: DSSpacing.s10),
        child: SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
            itemCount: count,
            separatorBuilder: (context, index) =>
                const SizedBox(width: _storyGap),
            itemBuilder: (context, index) =>
                const SkeletonCircle(size: _storySize),
          ),
        ),
      ),
    );
  }
}

class _PodcastBannerSkeletonSliver extends StatelessWidget {
  const _PodcastBannerSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: DSSpacing.xl),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
          child: AspectRatio(
            aspectRatio: 329 / 169,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    SkeletonBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      radius: DSRadius.m,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(DSSpacing.m),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LayoutBuilder(
                            builder: (context, inner) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SkeletonLine(
                                    width: inner.maxWidth * 0.55,
                                    height: 18,
                                  ),
                                  const SizedBox(height: DSSpacing.s6),
                                  SkeletonLine(
                                    width: inner.maxWidth * 0.42,
                                    height: 18,
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: DSSpacing.s20),
                          LayoutBuilder(
                            builder: (context, inner) {
                              return SkeletonLine(width: inner.maxWidth * 0.35);
                            },
                          ),
                          const SizedBox(height: DSSpacing.s12),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SkeletonCircle(size: DSIconSize.s20),
                              SizedBox(width: DSSpacing.s8),
                              SkeletonLine(width: 90),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedPlaylistsHeaderSkeletonSliver extends StatelessWidget {
  const _FeaturedPlaylistsHeaderSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: DSSpacing.xl, bottom: DSSpacing.m),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
          child: Row(
            children: [
              SkeletonLine(width: 190, height: 18),
              SizedBox(width: DSSpacing.xs),
              SkeletonBox(width: 16, height: 17, radius: DSRadius.xs),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedPlaylistsCarouselSkeletonSliver extends StatelessWidget {
  const _FeaturedPlaylistsCarouselSkeletonSliver();

  static const double _cardWidth = 140;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 210,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
          itemCount: 6,
          separatorBuilder: (context, index) =>
              const SizedBox(width: DSSpacing.s12),
          itemBuilder: (context, index) {
            return SizedBox(
              width: _cardWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SkeletonBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          radius: DSRadius.l,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: DSSpacing.s6),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(width: constraints.maxWidth),
                          const SizedBox(height: DSSpacing.s6),
                          SkeletonLine(width: constraints.maxWidth * 0.7),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: DSSpacing.s6),
                  const SkeletonLine(width: 72),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NewsHeaderSkeletonSliver extends StatelessWidget {
  const _NewsHeaderSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: DSSpacing.xl, bottom: DSSpacing.m),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
          child: Row(
            children: [
              SkeletonLine(width: 72, height: 18),
              SizedBox(width: DSSpacing.s8),
              SkeletonCircle(size: DSIconSize.s16),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsListSkeletonSliver extends StatelessWidget {
  const _NewsListSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final isLast = index == 2;

        return Column(
          children: [
            const _NewsItemSkeleton(),
            if (!isLast) ...[
              const SizedBox(height: DSSpacing.s10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
                child: SkeletonLine(width: double.infinity, height: 1),
              ),
              const SizedBox(height: DSSpacing.s10),
            ],
          ],
        );
      }, childCount: 3),
    );
  }
}

class _NewsItemSkeleton extends StatelessWidget {
  const _NewsItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: DSSpacing.s8,
        horizontal: DSSpacing.m,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SkeletonBox(width: 84, height: 84, radius: DSRadius.s),
          SizedBox(width: DSSpacing.s12),
          Expanded(child: _NewsTitleSkeleton()),
        ],
      ),
    );
  }
}

class _NewsTitleSkeleton extends StatelessWidget {
  const _NewsTitleSkeleton();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 84,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLine(width: constraints.maxWidth),
              const SizedBox(height: DSSpacing.s6),
              SkeletonLine(width: constraints.maxWidth * 0.9),
              const SizedBox(height: DSSpacing.s6),
              SkeletonLine(width: constraints.maxWidth * 0.65),
            ],
          ),
        );
      },
    );
  }
}
