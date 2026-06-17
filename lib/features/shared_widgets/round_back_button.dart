import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_router/go_router.dart';

class RoundBackButton extends StatelessWidget {
  final double cardHeight;
  final String goBackTo;

  const RoundBackButton({
    required this.cardHeight,
    required this.goBackTo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: cardHeight + 20,
      left: DSSpacing.m,
      child: GestureDetector(
        onTap: () => context.go(goBackTo),
        child: Container(
          padding: const EdgeInsets.all(DSSpacing.s12),
          decoration: const BoxDecoration(
            color: DSColors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: DSColors.gray10, blurRadius: 8)],
          ),
          child: const Icon(
            Icons.arrow_back,
            color: DSColors.blue,
            size: DSIconSize.s24,
          ),
        ),
      ),
    );
  }
}
