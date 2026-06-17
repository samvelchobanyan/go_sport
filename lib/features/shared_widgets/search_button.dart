import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/search/presentation/search/search_screen.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;
  final Color iconColor;
  final bool decoration;

  const SearchButton({
    super.key,
    this.onTap,
    this.size = 24,
    this.iconColor = DSColors.black,
    this.decoration = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = SvgPicture.asset(
      'assets/icons/search.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        decoration ? DSColors.white : iconColor,
        BlendMode.srcIn,
      ),
    );

    if (decoration) {
      iconWidget = Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: DSColors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: iconWidget,
      );
    }

    return IconButton(
      icon: iconWidget,
      onPressed: onTap ?? () => showSearchBottomSheet(context),
    );
  }
}
