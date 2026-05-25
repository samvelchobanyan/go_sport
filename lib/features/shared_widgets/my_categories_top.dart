import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/shared_widgets/search_button.dart';

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

                  SearchButton(
                    onTap: () {
                      // TODO: открыть поиск
                    },
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
          GestureDetector(
            onTap: onActionIconTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: DSColors.blue,
                shape: BoxShape.circle,
              ),
              child: Center(child: actionIcon),
            ),
          ),
        ],
      ],
    );
  }
}
