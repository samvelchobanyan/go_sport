import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsets padding;

  const BottomSheetContainer({
    super.key,
    required this.child,
    this.height,
    this.padding = const EdgeInsets.all(DSSpacing.m),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: DSColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DSRadius.l),
          topRight: Radius.circular(DSRadius.l),
        ),
      ),
      child: Column(
        mainAxisSize: height == null ? MainAxisSize.min : MainAxisSize.max,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: DSSpacing.s12, bottom: DSSpacing.m),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: DSColors.gray20,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Content
          if (height != null)
            Expanded(
              child: Padding(
                padding: padding,
                child: child,
              ),
            )
          else
            Padding(
              padding: padding,
              child: child,
            ),
        ],
      ),
    );
  }
}
