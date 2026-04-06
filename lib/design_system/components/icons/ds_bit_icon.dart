import 'package:flutter/material.dart';

class DSBitIcon extends StatefulWidget {
  final Color color;
  final double size;
  final bool isAnimated;

  const DSBitIcon({
    super.key,
    required this.color,
    this.size = 24.0,
    this.isAnimated = false,
  });

  @override
  State<DSBitIcon> createState() => _DSBitIconState();
}

class _DSBitIconState extends State<DSBitIcon>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant DSBitIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimated != oldWidget.isAnimated) {
      _initAnimation();
    }
  }

  void _initAnimation() {
    if (widget.isAnimated) {
      _controller ??= AnimationController(
        duration: const Duration(milliseconds: 1200),
        vsync: this,
      )..repeat();
    } else {
      _controller?.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build( context) {
    if (_controller != null) {
      return AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _BitIconPainter(
              color: widget.color,
              animationValue: _controller!.value,
            ),
          );
        },
      );
    }

    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: _BitIconPainter(
        color: widget.color,
        animationValue: null,
      ),
    );
  }
}

class _BitIconPainter extends CustomPainter {
  final Color color;
  final double? animationValue;

  _BitIconPainter({
    required this.color,
    this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 24.0;
    final cornerRadius = 1.0 * scale;

    final bars = [
      {'x': 3.0, 'y': 1.97156, 'height': 19.9519},
      {'x': 6.99991, 'y': 3.56152, 'height': 16.772},
      {'x': 11.0001, 'y': 0.577515, 'height': 22.7399},
      {'x': 15.0, 'y': 7.45361, 'height': 8.98779},
      {'x': 18.9999, 'y': 5.94739, 'height': 12.0},
    ];

    for (int i = 0; i < bars.length; i++) {
      final bar = bars[i];
      final baseX = bar['x']! * scale;
      final baseY = bar['y']! * scale;
      final baseHeight = bar['height']! * scale;

      double height = baseHeight;
      double y = baseY;

      if (animationValue != null) {
        final phase = i * 0.2;
        final wave = (animationValue! + phase) % 1.0;
        final bounce = 1.0 - (wave - 0.5).abs() * 2;
        final heightMultiplier = 0.5 + (bounce * 0.5);
        height = baseHeight * heightMultiplier;
        final heightDiff = baseHeight - height;
        y = baseY + (heightDiff / 2);
      }

      final barRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(baseX, y, 2.0 * scale, height),
        Radius.circular(cornerRadius),
      );

      canvas.drawRRect(barRect, paint);
    }
  }

  @override
  bool shouldRepaint(_BitIconPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue;
  }
}
