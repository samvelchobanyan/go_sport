import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

class SkeletonCircle extends StatelessWidget {
  const SkeletonCircle({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: DSColors.gray10,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
