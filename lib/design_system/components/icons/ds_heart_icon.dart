import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DSHeartIcon extends StatelessWidget {
  final Color color;
  final double size;
  final bool isFilled;

  const DSHeartIcon({
    super.key,
    required this.color,
    this.size = 32.0,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isFilled 
        ? 'assets/icons/heart_fill.svg' 
        : 'assets/icons/heart_stroke.svg',
      colorFilter: ColorFilter.mode(
        color.withValues(alpha: 0.6),
        BlendMode.srcIn,
      ),
      width: size,
      height: size,
    );
  }
}
