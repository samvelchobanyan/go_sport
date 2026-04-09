import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class PlaylistScreenSkeleton extends StatelessWidget {
  const PlaylistScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final heroHeight = screenHeight * 0.5;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          // Hero skeleton
          Container(
            height: heroHeight,
            color: DSColors.gray20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Title skeleton
                Container(
                  width: 200,
                  height: 32,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: DSColors.gray40,
                    borderRadius: BorderRadius.circular(DSRadius.xs),
                  ),
                ),
                // Buttons skeleton
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: DSColors.gray40,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: DSColors.gray40,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          
          // Tracks skeleton
          Container(
            decoration: BoxDecoration(
              color: DSColors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              children: List.generate(6, (index) => _buildTrackSkeleton()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
          const SizedBox(width: 12),
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
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: DSColors.gray20,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
