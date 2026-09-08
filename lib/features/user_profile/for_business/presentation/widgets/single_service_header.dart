import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';

class SingleServiceHeader extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? subtitle;
  final SvgPicture? actionIcon;
  final VoidCallback? onActionIconTap;
  final int itemCount;

  const SingleServiceHeader({
    super.key,
    required this.iconPath,
    required this.title,
    this.subtitle,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DSSpacing.m,
                vertical: DSSpacing.s20,
              ),
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
  final String? subtitle;
  final SvgPicture? actionIcon;
  final VoidCallback? onActionIconTap;
  final int itemCount;

  const _MyCategoriesHeaderContent({
    required this.iconPath,
    required this.title,
    this.subtitle,
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
              SvgPicture.network(
                iconPath,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                placeholderBuilder: (context) => const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              const SizedBox(width: DSSpacing.s12),

              Expanded(child: Text(title, style: context.h2)),
            ],
          ),
        ),
        if (actionIcon != null) ...[
          const SizedBox(width: DSSpacing.s12),
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
