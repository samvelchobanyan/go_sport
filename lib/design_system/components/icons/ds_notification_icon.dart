import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DSNotificationIcon extends StatelessWidget {
  final Color color;
  final double size;
  final bool isFilled;

  const DSNotificationIcon({
    super.key,
    required this.color,
    this.size = 32.0,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isFilled ? 'assets/icons/bell_fill.svg' : 'assets/icons/bell_stroke.svg',
      colorFilter: ColorFilter.mode(color.withOpacity(0.6), BlendMode.srcIn),
      width: size,
      height: size,
    );
  }
}
