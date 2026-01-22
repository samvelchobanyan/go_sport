import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class SkeletonLine extends StatelessWidget {
  const SkeletonLine({
    super.key,
    required this.width,
    this.height = 14,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: DSColors.gray10,
          borderRadius: BorderRadius.circular(DSRadius.xs),
        ),
      ),
    );
  }
}
