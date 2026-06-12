import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class ArtistScreenSkeleton extends StatelessWidget {
  final int itemCount;

  const ArtistScreenSkeleton({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: DSLayout.bottomBarClearance),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAlbumSkeleton(),
              if (index < itemCount - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: DSSpacing.l),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: DSColors.gray20,
                  ),
                ),
            ],
          );
        }, childCount: itemCount),
      ),
    );
  }

  Widget _buildAlbumSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m, vertical: DSSpacing.s12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: DSColors.gray20,
              borderRadius: BorderRadius.circular(DSRadius.s),
            ),
          ),
          const SizedBox(width: DSSpacing.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 16,
                  decoration: BoxDecoration(
                    color: DSColors.gray20,
                    borderRadius: BorderRadius.circular(DSRadius.xs),
                  ),
                ),
                const SizedBox(height: DSSpacing.s6),
                Container(
                  width: 110,
                  height: 14,
                  decoration: BoxDecoration(
                    color: DSColors.gray20,
                    borderRadius: BorderRadius.circular(DSRadius.xs),
                  ),
                ),
                const SizedBox(height: DSSpacing.s6),
                Container(
                  width: 64,
                  height: 14,
                  decoration: BoxDecoration(
                    color: DSColors.gray20,
                    borderRadius: BorderRadius.circular(DSRadius.xs),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: DSSpacing.s12),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: DSColors.gray20,
              borderRadius: BorderRadius.circular(DSRadius.s),
            ),
          ),
        ],
      ),
    );
  }
}