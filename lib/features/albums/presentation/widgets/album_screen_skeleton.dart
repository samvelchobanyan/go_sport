import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class AlbumScreenSkeleton extends StatelessWidget {
  final int itemCount;

  const AlbumScreenSkeleton({super.key, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: DSLayout.bottomBarClearance),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSkeleton(),
              if (index < itemCount - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: DSSpacing.l),
                  child: Divider(height: 1, thickness: 1, color: DSColors.gray20),
                ),
            ],
          );
        }, childCount: itemCount),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m, vertical: DSSpacing.s12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: DSColors.gray20,
              borderRadius: BorderRadius.circular(DSRadius.s),
            ),
          ),
          const SizedBox(width: DSSpacing.s12),
          Expanded(
            child: Container(
              width: 150,
              height: 16,
              decoration: BoxDecoration(
                color: DSColors.gray20,
                borderRadius: BorderRadius.circular(DSRadius.xs),
              ),
            ),
          ),
          const SizedBox(width: DSSpacing.s12),
          Container(
            width: 40,
            height: 40,
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
