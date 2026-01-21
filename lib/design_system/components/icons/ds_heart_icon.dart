import 'package:flutter/material.dart';

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
    return CustomPaint(
      size: Size(size, size),
      painter: _HeartIconPainter(
        color: color,
        isFilled: isFilled,
      ),
    );
  }
}

class _HeartIconPainter extends CustomPainter {
  final Color color;
  final bool isFilled;

  _HeartIconPainter({
    required this.color,
    required this.isFilled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final opacity = isFilled ? 0.6 : 0.7;
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = isFilled ? 0 : 1.2;

    final scale = size.width / 32.0;

    final path = Path();
    
    // SVG path: M12.0872 21.9652C9.28788 19.8012 6 17.2595 6 12.8534C6 7.98947 11.483 4.54002 15.9688 9.2162L17.9625 11.2153C18.2545 11.5082 18.7279 11.5081 19.0199 11.2151C19.3118 10.9221 19.3117 10.4471 19.0197 10.1542L17.0937 8.22247C21.3205 5.11777 25.9375 8.39003 25.9375 12.8534C25.9375 17.2595 22.6496 19.8011 19.8503 21.9652C19.5594 22.19 19.2737 22.4109 18.9976 22.6293C17.9625 23.448 16.9656 24.2188 15.9688 24.2188C14.9719 24.2188 13.975 23.448 12.94 22.6293C12.6638 22.4109 12.3781 22.19 12.0872 21.9652Z
    path.moveTo(12.0872 * scale, 21.9652 * scale);
    path.cubicTo(
      9.28788 * scale, 19.8012 * scale,
      6 * scale, 17.2595 * scale,
      6 * scale, 12.8534 * scale,
    );
    path.cubicTo(
      6 * scale, 7.98947 * scale,
      11.483 * scale, 4.54002 * scale,
      15.9688 * scale, 9.2162 * scale,
    );
    path.lineTo(17.9625 * scale, 11.2153 * scale);
    path.cubicTo(
      18.2545 * scale, 11.5082 * scale,
      18.7279 * scale, 11.5081 * scale,
      19.0199 * scale, 11.2151 * scale,
    );
    path.cubicTo(
      19.3118 * scale, 10.9221 * scale,
      19.3117 * scale, 10.4471 * scale,
      19.0197 * scale, 10.1542 * scale,
    );
    path.lineTo(17.0937 * scale, 8.22247 * scale);
    path.cubicTo(
      21.3205 * scale, 5.11777 * scale,
      25.9375 * scale, 8.39003 * scale,
      25.9375 * scale, 12.8534 * scale,
    );
    path.cubicTo(
      25.9375 * scale, 17.2595 * scale,
      22.6496 * scale, 19.8011 * scale,
      19.8503 * scale, 21.9652 * scale,
    );
    path.cubicTo(
      19.5594 * scale, 22.19 * scale,
      19.2737 * scale, 22.4109 * scale,
      18.9976 * scale, 22.6293 * scale,
    );
    path.cubicTo(
      17.9625 * scale, 23.448 * scale,
      16.9656 * scale, 24.2188 * scale,
      15.9688 * scale, 24.2188 * scale,
    );
    path.cubicTo(
      14.9719 * scale, 24.2188 * scale,
      13.975 * scale, 23.448 * scale,
      12.94 * scale, 22.6293 * scale,
    );
    path.cubicTo(
      12.6638 * scale, 22.4109 * scale,
      12.3781 * scale, 22.19 * scale,
      12.0872 * scale, 21.9652 * scale,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HeartIconPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isFilled != isFilled;
  }
}
