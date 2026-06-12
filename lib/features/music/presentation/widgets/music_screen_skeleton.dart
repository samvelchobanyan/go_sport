import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/wave_section_header.dart';

class MusicQuickActionsSkeleton extends StatelessWidget {
  final double cardWidth;

  const MusicQuickActionsSkeleton({
    super.key,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DSSpacing.m),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
          6,
          (_) => SizedBox(
            width: cardWidth,
            child: const _QuickActionCardSkeleton(),
          ),
        ),
      ),
    );
  }
}

class MusicPlaylistsSkeletonSection extends StatelessWidget {
  const MusicPlaylistsSkeletonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _MediaSectionSkeleton(
      title: 'Featured playlists',
      child: SizedBox(
        height: 210,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
          itemCount: 3,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(right: DSSpacing.s12),
            child: _PlaylistCardSkeleton(),
          ),
        ),
      ),
    );
  }
}

class MusicAlbumsSkeletonSection extends StatelessWidget {
  const MusicAlbumsSkeletonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _MediaSectionSkeleton(
      title: 'Featured albums',
      child: SizedBox(
        height: 260,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
          itemCount: 3,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(right: DSSpacing.s12),
            child: _AlbumCardSkeleton(),
          ),
        ),
      ),
    );
  }
}

class MusicArtistsSkeletonSection extends StatelessWidget {
  const MusicArtistsSkeletonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _MediaSectionSkeleton(
      title: 'Featured artists',
      child: SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
          itemCount: 3,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(right: DSSpacing.m),
            child: _ArtistCardSkeleton(),
          ),
        ),
      ),
    );
  }
}

class _MediaSectionSkeleton extends StatelessWidget {
  final String title;
  final Widget child;

  const _MediaSectionSkeleton({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DSColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: DSSpacing.m),
            child: WaveSectionHeader(
              title: title,
              showAnimation: true,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _QuickActionCardSkeleton extends StatelessWidget {
  const _QuickActionCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DSSpacing.s8),
      decoration: BoxDecoration(
        color: DSColors.white80,
        borderRadius: BorderRadius.circular(DSRadius.s),
      ),
      child: Row(
        children: [
          const _SkeletonBox(
            width: 44,
            height: 44,
            borderRadius: 22,
          ),
          const SizedBox(width: DSSpacing.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _SkeletonBox(width: 92, height: 14, borderRadius: 4),
                SizedBox(height: DSSpacing.s6),
                _SkeletonBox(width: 72, height: 12, borderRadius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaylistCardSkeleton extends StatelessWidget {
  const _PlaylistCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SkeletonBox(width: 140, height: 140, borderRadius: 12),
          SizedBox(height: DSSpacing.s6),
          _SkeletonBox(width: 116, height: 16, borderRadius: 4),
          SizedBox(height: DSSpacing.s6),
          _SkeletonBox(width: 70, height: 20, borderRadius: 10),
        ],
      ),
    );
  }
}

class _AlbumCardSkeleton extends StatelessWidget {
  const _AlbumCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SkeletonBox(width: 140, height: 140, borderRadius: 12),
          SizedBox(height: DSSpacing.s6),
          _SkeletonBox(width: 112, height: 16, borderRadius: 4),
          SizedBox(height: DSSpacing.xs),
          _SkeletonBox(width: 88, height: 14, borderRadius: 4),
          SizedBox(height: DSSpacing.s6),
          _SkeletonBox(width: 70, height: 20, borderRadius: 10),
        ],
      ),
    );
  }
}

class _ArtistCardSkeleton extends StatelessWidget {
  const _ArtistCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SkeletonBox(width: 120, height: 120, borderRadius: 60),
          SizedBox(height: DSSpacing.s12),
          _SkeletonBox(width: 92, height: 16, borderRadius: 4),
          SizedBox(height: DSSpacing.s6),
          _SkeletonBox(width: 70, height: 16, borderRadius: 4),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _SkeletonBox({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: DSColors.gray20,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}