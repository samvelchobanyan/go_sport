import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;
  final Color iconColor;

  const SearchButton({
    super.key,
    this.onTap,
    this.size = 24,
    this.iconColor = DSColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        Icons.search,
        size: size,
        color: iconColor,
      ),
      splashRadius: 24,
    );
  }
}