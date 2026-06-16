import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_box.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_circle.dart';
import 'package:go_sport/design_system/components/skeleton/skeleton_line.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/user_avatar_button.dart';

class RadioPageSkeleton extends StatelessWidget {
  const RadioPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: const [
        _RadioAppBarSliver(),
        _LiveBannerSkeletonSliver(),
        _ProgramsSectionSkeletonSliver(),
        _EpisodesHeaderSkeletonSliver(),
        _EpisodesListSkeletonSliver(),
      ],
    );
  }
}

class _RadioAppBarSliver extends StatelessWidget {
  const _RadioAppBarSliver();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: DSColors.white,
      elevation: 0,
      pinned: true,
      floating: true,
      leading: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 16,
        ),
        child: UserAvatarButton(
          imageUrl: null,
          onTap: () {},
        ),
      ),
      title: const Text('Radio'),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: DSSpacing.s12, horizontal: DSSpacing.m),
          child: SkeletonBox(width: 24, height: 24, radius: DSRadius.xs),
        ),
      ],
    );
  }
}

class _LiveBannerSkeletonSliver extends StatelessWidget {
  const _LiveBannerSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: DSSpacing.s18, left: DSSpacing.m, right: DSSpacing.m),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SkeletonBox(
                  width: constraints.maxWidth,
                  height: 64,
                  radius: DSRadius.s,
                ),
                const Padding(
                  padding: EdgeInsets.all(DSSpacing.s10),
                  child: Row(
                    children: [
                      SkeletonCircle(size: DSIconSize.s28),
                      SizedBox(width: DSSpacing.s14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SkeletonLine(width: 120, height: 16),
                            SizedBox(height: DSSpacing.s6),
                            SkeletonLine(width: 92, height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProgramsSectionSkeletonSliver extends StatelessWidget {
  const _ProgramsSectionSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DSSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SectionHeaderSkeleton(),
            SizedBox(height: DSSpacing.s10),
            _ProgramsCarouselSkeleton(),
          ],
        ),
      ),
    );
  }
}

class _EpisodesHeaderSkeletonSliver extends StatelessWidget {
  const _EpisodesHeaderSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: _SectionHeaderSkeleton(),
    );
  }
}

class _SectionHeaderSkeleton extends StatelessWidget {
  const _SectionHeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
      child: Row(
        children: [
          SkeletonLine(width: 180, height: 18),
          SizedBox(width: DSSpacing.xs),
          SkeletonBox(width: 16, height: 17, radius: DSRadius.xs),
        ],
      ),
    );
  }
}

class _ProgramsCarouselSkeleton extends StatelessWidget {
  const _ProgramsCarouselSkeleton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(width: DSSpacing.s12),
        itemBuilder: (context, index) => const _ProgramCardSkeleton(),
      ),
    );
  }
}

class _ProgramCardSkeleton extends StatelessWidget {
  const _ProgramCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(width: 140, height: 140, radius: DSRadius.l),
          SizedBox(height: DSSpacing.s6),
          SkeletonLine(width: 132, height: 14),
          SizedBox(height: DSSpacing.xs),
          SkeletonLine(width: 96, height: 14),
          SizedBox(height: DSSpacing.s6),
          SkeletonBox(width: 72, height: 20, radius: 10),
        ],
      ),
    );
  }
}

class _EpisodesListSkeletonSliver extends StatelessWidget {
  const _EpisodesListSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: DSLayout.bottomBarClearance),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: const [
                _EpisodeTileSkeleton(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
                  child: SkeletonLine(width: double.infinity, height: 1),
                ),
              ],
            );
          },
          childCount: 6,
        ),
      ),
    );
  }
}

class _EpisodeTileSkeleton extends StatelessWidget {
  const _EpisodeTileSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: DSSpacing.m, vertical: DSSpacing.s12),
      child: Row(
        children: [
          SkeletonBox(width: 48, height: 48, radius: DSRadius.xs),
          SizedBox(width: DSSpacing.s10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(width: double.infinity, height: 14),
                SizedBox(height: DSSpacing.s6),
                SkeletonLine(width: 110, height: 12),
              ],
            ),
          ),
          SizedBox(width: DSSpacing.s12),
          SkeletonBox(width: 24, height: 24, radius: 4),
        ],
      ),
    );
  }
}