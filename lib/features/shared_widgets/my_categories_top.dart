import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

class MyCategoriesHeader extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final SvgPicture? actionIcon;
  final VoidCallback? onActionIconTap;
  final int itemCount;

  const MyCategoriesHeader({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.actionIcon,
    this.onActionIconTap,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DSColors.transparent,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: DSColors.black),
                    onPressed: () => context.pop(),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.search, color: DSColors.black),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: _MyCategoriesHeaderContent(
                iconPath: iconPath,
                title: title,
                subtitle: subtitle,
                actionIcon: actionIcon,
                onActionIconTap: onActionIconTap,
                itemCount: itemCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCategoriesTop extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final SvgPicture? actionIcon;
  final VoidCallback? onActionIconTap;
  final int itemCount;

  const MyCategoriesTop({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.actionIcon,
    this.onActionIconTap,
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
          child: _MyCategoriesHeaderContent(
            iconPath: iconPath,
            title: title,
            subtitle: subtitle,
            actionIcon: actionIcon,
            onActionIconTap: onActionIconTap,
            itemCount: itemCount,
          ),
        ),
      ),
    );
  }
}

class _MyCategoriesHeaderContent extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final SvgPicture? actionIcon;
  final VoidCallback? onActionIconTap;
  final int itemCount;

  const _MyCategoriesHeaderContent({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.actionIcon,
    required this.onActionIconTap,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              SvgPicture.asset(iconPath, width: 40, height: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: context.h2),
                    const SizedBox(height: 4),
                    Text('$itemCount $subtitle', style: context.textL),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (actionIcon != null) ...[
          const SizedBox(width: 12),
          GestureDetector(onTap: onActionIconTap, child: actionIcon),
        ],
      ],
    );
  }
}
