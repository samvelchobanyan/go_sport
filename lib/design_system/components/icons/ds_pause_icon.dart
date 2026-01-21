import 'package:flutter/material.dart';

class DSPauseIcon extends StatelessWidget {
  final Color color;
  final double size;

  const DSPauseIcon({
    super.key,
    required this.color,
    this.size = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PauseIconPainter(color: color),
    );
  }
}

class _PauseIconPainter extends CustomPainter {
  final Color color;

  _PauseIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 32.0;

    // First rounded rectangle (left bar)
    // SVG: x="8" y="8" width="6.4" height="16" with rounded corners
    final leftRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        8.0 * scale,
        8.0 * scale,
        6.4 * scale,
        16.0 * scale,
      ),
      Radius.circular(0.468631 * scale), // Corner radius scaled
    );

    // Second rounded rectangle (right bar)
    // SVG: x="17.6" y="8" width="6.4" height="16" with rounded corners
    final rightRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        17.6 * scale,
        8.0 * scale,
        6.4 * scale,
        16.0 * scale,
      ),
      Radius.circular(0.468631 * scale), // Corner radius scaled
    );

    canvas.drawRRect(leftRect, paint);
    canvas.drawRRect(rightRect, paint);
  }

  @override
  bool shouldRepaint(_PauseIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
