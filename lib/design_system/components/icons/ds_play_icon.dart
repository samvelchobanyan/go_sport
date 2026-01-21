import 'package:flutter/material.dart';

class DSPlayIcon extends StatelessWidget {
  final Color color;
  final double size;

  const DSPlayIcon({
    super.key,
    required this.color,
    this.size = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PlayIconPainter(color: color),
    );
  }
}

class _PlayIconPainter extends CustomPainter {
  final Color color;

  _PlayIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 32.0;

    final path = Path();
    
    // SVG path: M22.8274 13.8821C24.3909 14.8052 24.3909 17.1948 22.8274 18.1179L13.387 23.6916C11.8674 24.5888 10 23.421 10 21.5737V10.4263C10 8.57894 11.8674 7.41122 13.387 8.30838L22.8274 13.8821Z
    path.moveTo(22.8274 * scale, 13.8821 * scale);
    path.cubicTo(
      24.3909 * scale, 14.8052 * scale,
      24.3909 * scale, 17.1948 * scale,
      22.8274 * scale, 18.1179 * scale,
    );
    path.lineTo(13.387 * scale, 23.6916 * scale);
    path.cubicTo(
      11.8674 * scale, 24.5888 * scale,
      10 * scale, 23.421 * scale,
      10 * scale, 21.5737 * scale,
    );
    path.lineTo(10 * scale, 10.4263 * scale);
    path.cubicTo(
      10 * scale, 8.57894 * scale,
      11.8674 * scale, 7.41122 * scale,
      13.387 * scale, 8.30838 * scale,
    );
    path.lineTo(22.8274 * scale, 13.8821 * scale);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_PlayIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
