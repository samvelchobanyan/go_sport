import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class YoutubeBanner extends StatelessWidget {
  const YoutubeBanner({super.key});

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
              image: AssetImage('assets/images/program_banner.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/youtube_orange.svg'),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Watch all Episodes of the show on YouTube channel!',
                    style: context.subtitleLBold?.copyWith(
                      color: DSColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
