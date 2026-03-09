import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

class MyCategoriesTop extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback? onTapIcon;
  final int itemCount;

  const MyCategoriesTop({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.onTapIcon,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 132,
      backgroundColor: DSColors.transparent,
      elevation: 0,
      pinned: false,
      floating: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: DSColors.black),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: DSColors.black),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(iconPath, width: 40, height: 40),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.h2),
                      const SizedBox(width: 4),
                      Text('$itemCount $subtitle', style: context.textL),
                    ],
                  ),
                ],
              ),
              // Only show icon if onTapIcon callback is provided
              if (onTapIcon != null)
                GestureDetector(
                  onTap: onTapIcon,
                  child: SvgPicture.asset('assets/icons/play.svg'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
