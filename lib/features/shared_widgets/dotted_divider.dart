import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

class DottedDivider extends StatelessWidget {
  final Color color;
  final double dotSize;
  final double spacing;

  const DottedDivider({
    super.key,
    this.color = DSColors.gray20,
    this.dotSize = 2.0,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 1),
      painter: _DottedDividerPainter(
        color: color,
        dotSize: dotSize,
        spacing: spacing,
      ),
    );
  }
}

class _DottedDividerPainter extends CustomPainter {
  final Color color;
  final double dotSize;
  final double spacing;

  _DottedDividerPainter({
    required this.color,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double x = 0;
    while (x < size.width) {
      canvas.drawCircle(Offset(x, size.height / 2), dotSize / 2, paint);
      x += dotSize + spacing;
    }
  }

  @override
  bool shouldRepaint(_DottedDividerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dotSize != dotSize ||
        oldDelegate.spacing != spacing;
  }
}
