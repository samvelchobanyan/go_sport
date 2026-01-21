import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'dart:ui';

class MiniPlayerWidget extends StatelessWidget {
  const MiniPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(
        left: DSSpacing.m,
        right: DSSpacing.m,
        bottom: 0,
        top: 7,
      ),
      decoration: const BoxDecoration(
        color: DSColors.white,
      ),
      child: Container(
        height: 48,
        child: Row(
          children: [
            // Left: Radio button
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: DSColors.blue,
                borderRadius: BorderRadius.circular(DSRadius.m),
              ),
              child: const Icon(
                Icons.radio,
                color: DSColors.white,
                size: 20,
              ),
            ),

            const SizedBox(width: DSSpacing.s),

            // Center: Track info container
            Expanded(
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(
                  horizontal: DSSpacing.s,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: DSColors.storyGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(DSRadius.m),
                ),
                child: Row(
                  children: [
                    // Album cover
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: DSColors.white,
                        borderRadius: BorderRadius.circular(DSRadius.s),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=300&q=80',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: DSSpacing.s),

                    // Track info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Good Feelings',
                            style: context.subtitleM?.copyWith(
                              color: DSColors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Coldplay',
                            style: context.textL?.copyWith(
                              color: DSColors.grey20,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: DSSpacing.s),

            // Right controls
            Row(
              children: [
                // Like button
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: DSColors.transparent,
                    borderRadius: BorderRadius.circular(DSRadius.circular),
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: DSColors.black,
                    size: 20,
                  ),
                ),

                // Play button
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: DSColors.black,
                    borderRadius: BorderRadius.circular(DSRadius.circular),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: DSColors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
