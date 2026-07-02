import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/icons/ds_wave_icon.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class LiveBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const LiveBanner({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          right: DSSpacing.m,
          left: DSSpacing.m,
          top: DSSpacing.s18,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DSRadius.s),
              image: DecorationImage(
                image: AssetImage('assets/images/live_banner.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(DSSpacing.s10),
              child: Row(
                children: [
                  const DSWaveIcon(isAnimated: true),
                  SizedBox(width: DSSpacing.s14),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Listen Live Now',
                          style: context.h3?.copyWith(color: DSColors.white),
                        ),
                        // SizedBox(height: DSSpacing.xs),
                        Text(
                          'We Get the Cup',
                          style: context.textL?.copyWith(color: DSColors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
