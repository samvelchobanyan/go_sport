import 'package:flutter/material.dart';

class DSBitIcon extends StatelessWidget {
  final Color color;
  final double size;

  const DSBitIcon({
    super.key,
    required this.color,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _BitIconPainter(color: color),
    );
  }
}

class _BitIconPainter extends CustomPainter {
  final Color color;

  _BitIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 24.0;
    final cornerRadius = 1.0 * scale; // rx="1" from SVG

    // Bar 1: x="3" y="1.97156" width="2" height="19.9519"
    final bar1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        3.0 * scale,
        1.97156 * scale,
        2.0 * scale,
        19.9519 * scale,
      ),
      Radius.circular(cornerRadius),
    );

    // Bar 2: x="6.99991" y="3.56152" width="2" height="16.772"
    final bar2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        6.99991 * scale,
        3.56152 * scale,
        2.0 * scale,
        16.772 * scale,
      ),
      Radius.circular(cornerRadius),
    );

    // Bar 3: x="11.0001" y="0.577515" width="2" height="22.7399"
    final bar3 = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        11.0001 * scale,
        0.577515 * scale,
        2.0 * scale,
        22.7399 * scale,
      ),
      Radius.circular(cornerRadius),
    );

    // Bar 4: x="15" y="7.45361" width="2" height="8.98779"
    final bar4 = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        15.0 * scale,
        7.45361 * scale,
        2.0 * scale,
        8.98779 * scale,
      ),
      Radius.circular(cornerRadius),
    );

    // Bar 5: x="18.9999" y="5.94739" width="2" height="12"
    final bar5 = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        18.9999 * scale,
        5.94739 * scale,
        2.0 * scale,
        12.0 * scale,
      ),
      Radius.circular(cornerRadius),
    );

    canvas.drawRRect(bar1, paint);
    canvas.drawRRect(bar2, paint);
    canvas.drawRRect(bar3, paint);
    canvas.drawRRect(bar4, paint);
    canvas.drawRRect(bar5, paint);
  }

  @override
  bool shouldRepaint(_BitIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
