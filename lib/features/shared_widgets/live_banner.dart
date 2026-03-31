import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/live_wave_icon.dart';

class LiveBanner extends StatelessWidget {
  const LiveBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 16, left: 16, top: 18),
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
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const AnimatedPlayWaves(),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Listen Live Now',
                      style: context.h3?.copyWith(color: DSColors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'We Get the Cup',
                      style: context.textL?.copyWith(color: DSColors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
