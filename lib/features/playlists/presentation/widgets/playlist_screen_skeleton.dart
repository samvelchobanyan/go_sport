import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class PlaylistScreenSkeleton extends StatelessWidget {
  final int itemCount;

  const PlaylistScreenSkeleton({super.key, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTrackSkeleton(),
              if (index < itemCount - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
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

  Widget _buildTrackSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Image skeleton
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: DSColors.gray20,
              borderRadius: BorderRadius.circular(DSRadius.xs),
            ),
          ),
          const SizedBox(width: 10),
          // Text skeletons
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 16,
                  decoration: BoxDecoration(
                    color: DSColors.gray20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 100,
                  height: 14,
                  decoration: BoxDecoration(
                    color: DSColors.gray20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          // Menu skeleton
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: DSColors.gray20,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
