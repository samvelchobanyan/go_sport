import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_box.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_circle.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_line.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

import '../../../../shared_widgets/search_button.dart';
import '../../../../shared_widgets/user_avatar_button.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: const [
        _HomeAppBarSliver(),
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

class _HomeAppBarSliver extends StatelessWidget {
  const _HomeAppBarSliver();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: DSColors.white,
      elevation: 0,
      pinned: true,
      floating: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserAvatarButton(
          imageUrl: null,
          onTap: () {},
        ),
      ),
      title: SvgPicture.asset(
        'assets/icons/app_logo.svg',
        height: 40,
      ),
      centerTitle: true,
      actions: [
        SearchButton(
          onTap: () {},
        ),
      ],
    );
  }
}

class _StoriesRowSkeletonSliver extends StatelessWidget {
  const _StoriesRowSkeletonSliver();

  static const double _storySize = 72;
  static const double _storyGap = 8;

  int _estimateStoryCount(double screenWidth) {
    const horizontalPadding = 16.0 * 2;
    final available = math.max(0.0, screenWidth - horizontalPadding);
    final itemExtent = _storySize + _storyGap;
    return math.max(1, (available / itemExtent).floor());
  }

  @override
  Widget build(BuildContext context) {
    final count = _estimateStoryCount(MediaQuery.sizeOf(context).width);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: count,
            separatorBuilder: (context, index) => const SizedBox(width: _storyGap),
            itemBuilder: (context, index) => const SkeletonCircle(size: _storySize),
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
        padding: const EdgeInsets.only(top: 32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.5),
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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LayoutBuilder(
                            builder: (context, inner) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SkeletonLine(width: inner.maxWidth * 0.55, height: 18),
                                  const SizedBox(height: 6),
                                  SkeletonLine(width: inner.maxWidth * 0.42, height: 18),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 21),
                          LayoutBuilder(
                            builder: (context, inner) {
                              return SkeletonLine(width: inner.maxWidth * 0.35);
                            },
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SkeletonCircle(size: 20),
                              SizedBox(width: 8),
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
        padding: EdgeInsets.only(top: 32, bottom: 16),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              SkeletonLine(width: 190, height: 18),
              SizedBox(width: 5),
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 6,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
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
                  const SizedBox(height: 6),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(width: constraints.maxWidth),
                          const SizedBox(height: 6),
                          SkeletonLine(width: constraints.maxWidth * 0.7),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 6),
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
        padding: EdgeInsets.only(top: 32, bottom: 16),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              SkeletonLine(width: 72, height: 18),
              SizedBox(width: 8),
              SkeletonCircle(size: 16),
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
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final isLast = index == 2;

          return Column(
            children: [
              const _NewsItemSkeleton(),
              if (!isLast) ...[
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SkeletonLine(width: double.infinity, height: 1),
                ),
                const SizedBox(height: 10),
              ],
            ],
          );
        },
        childCount: 3,
      ),
    );
  }
}

class _NewsItemSkeleton extends StatelessWidget {
  const _NewsItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SkeletonBox(width: 84, height: 84, radius: DSRadius.s),
          SizedBox(width: 11),
          Expanded(
            child: _NewsTitleSkeleton(),
          ),
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
              const SizedBox(height: 6),
              SkeletonLine(width: constraints.maxWidth * 0.9),
              const SizedBox(height: 6),
              SkeletonLine(width: constraints.maxWidth * 0.65),
            ],
          ),
        );
      },
    );
  }
}
