import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

class AnimatedPlayWaves extends StatefulWidget {
  const AnimatedPlayWaves({super.key});

  @override
  State<AnimatedPlayWaves> createState() => _AnimatedPlayWavesState();
}

class _AnimatedPlayWavesState extends State<AnimatedPlayWaves>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 50, // smaller
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          painter: _PlayWavesPainter(progress: _controller.value),
        ),
      ),
    );
  }
}

class _PlayWavesPainter extends CustomPainter {
  final double progress;
  static const Color color = DSColors.white;

  _PlayWavesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 🔹 Center triangle (smaller)
    final triangle = Path()
      ..moveTo(center.dx - 3, center.dy - 4)
      ..lineTo(center.dx - 3, center.dy + 4)
      ..lineTo(center.dx + 5, center.dy)
      ..close();
    canvas.drawPath(triangle, fillPaint);

    // 🔹 Waves (compact)
    const waveCount = 3;
    const baseRadius = 8.0;
    const radiusStep = 4.0;

    for (int i = 0; i < waveCount; i++) {
      final phase = (progress + i * 0.2) % 1.0;
      final radius = baseRadius + i * radiusStep + math.sin(phase * 2 * math.pi) * 1.5;

      final rect = Rect.fromCircle(center: center, radius: radius);
      final paint = Paint()
        ..color = color.withOpacity(0.3 + 0.7 * (1 - i / waveCount))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, math.pi * 0.75, math.pi * 0.5, false, paint);
      canvas.drawArc(rect, -math.pi * 0.25, math.pi * 0.5, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PlayWavesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// 🔹 Example usage
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: AnimatedPlayWaves()));
}