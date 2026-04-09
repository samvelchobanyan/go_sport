import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.radius,
  });

  final double width;
  final double height;

  /// Border radius in logical pixels.
  ///
  /// Prefer using design tokens like `DSRadius.m`.
  /// Defaults to a medium design-system radius.
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: DSColors.gray10,
          borderRadius: BorderRadius.circular(radius ?? DSRadius.m),
        ),
      ),
    );
  }
}
