// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:go_sport/design_system/foundations/ds_colors.dart';
// import 'package:go_sport/design_system/foundations/ds_radius.dart';

// class AnimatedPlayWaves extends StatefulWidget {
//   const AnimatedPlayWaves({super.key});

//   @override
//   State<AnimatedPlayWaves> createState() => _AnimatedPlayWavesState();
// }

// class _AnimatedPlayWavesState extends State<AnimatedPlayWaves>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         color: DSColors.white10,
//         borderRadius: BorderRadius.circular(DSRadius.s),
//       ),
//       child: SizedBox(
//         height: 44,
//         width: 44,
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (_, __) => CustomPaint(
//             painter: _PlayWavesPainter(progress: _controller.value),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _PlayWavesPainter extends CustomPainter {
//   final double progress;
//   static const Color color = DSColors.white;

//   _PlayWavesPainter({required this.progress});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);

//     final fillPaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     // 🔹 Center triangle (smaller)
//     final triangle = Path()
//       ..moveTo(center.dx - 3, center.dy - 4)
//       ..lineTo(center.dx - 3, center.dy + 4)
//       ..lineTo(center.dx + 5, center.dy)
//       ..close();
//     canvas.drawPath(triangle, fillPaint);

//     // 🔹 Waves (compact)
//     const waveCount = 3;
//     const baseRadius = 8.0;
//     const radiusStep = 4.0;

//     for (int i = 0; i < waveCount; i++) {
//       final phase = (progress + i * 0.2) % 1.0;
//       final radius =
//           baseRadius + i * radiusStep + math.sin(phase * 2 * math.pi) * 1.5;

//       final rect = Rect.fromCircle(center: center, radius: radius);
//       final paint = Paint()
//         ..color = color.withValues(alpha: 0.3 + 0.7 * (1 - i / waveCount))
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 1.5
//         ..strokeCap = StrokeCap.round;

//       canvas.drawArc(rect, math.pi * 0.75, math.pi * 0.5, false, paint);
//       canvas.drawArc(rect, -math.pi * 0.25, math.pi * 0.5, false, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant _PlayWavesPainter oldDelegate) =>
//       oldDelegate.progress != progress;
// }

// /// 🔹 Example usage
// class ExampleScreen extends StatelessWidget {
//   const ExampleScreen({super.key});

//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: AnimatedPlayWaves()));
// }

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: DSColors.white10,
        borderRadius: BorderRadius.circular(DSRadius.s),
      ),
      child: SizedBox(
        height: 44,
        width: 44,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => CustomPaint(
            painter: _PlayWavesPainter(progress: _controller.value),
          ),
        ),
      ),
    );
  }
}

// class _PlayWavesPainter extends CustomPainter {
//   final double progress;
//   static const Color color = DSColors.white;

//   _PlayWavesPainter({required this.progress});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);

//     final fillPaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill
//       ..strokeJoin = StrokeJoin.round; // Softens the edges slightly

//     // 🔹 Rounded Center Triangle
//     // Instead of sharp lines, we map out a path with tiny rounded curves
//     final trianglePath = Path();
//     const double radius = 1.0; // Rounding intensity for triangle corners

//     trianglePath.moveTo(center.dx - 2, center.dy - 4 + radius);
//     // Top point corner
//     trianglePath.lineTo(center.dx - 2, center.dy - 4);
//     trianglePath.quadraticBezierTo(
//       center.dx - 2,
//       center.dy - 4,
//       center.dx - 2 + radius,
//       center.dy - 4 + radius * 0.5,
//     );
//     // Front point corner
//     trianglePath.lineTo(center.dx + 4 - radius, center.dy - radius * 0.5);
//     trianglePath.quadraticBezierTo(
//       center.dx + 4,
//       center.dy,
//       center.dx + 4 - radius,
//       center.dy + radius * 0.5,
//     );
//     // Bottom point corner
//     trianglePath.lineTo(center.dx - 2 + radius, center.dy + 4 - radius * 0.5);
//     trianglePath.quadraticBezierTo(
//       center.dx - 2,
//       center.dy + 4,
//       center.dx - 2,
//       center.dy + 4 - radius,
//     );

//     trianglePath.close();
//     canvas.drawPath(trianglePath, fillPaint);

//     // 🔹 Waves (Shorter Arcs)
//     const waveCount = 3;
//     const baseRadius = 8.0;
//     const radiusStep = 3.0;

//     // Changing sweep angle from math.pi * 0.5 (90°) to math.pi * 0.35 (63°) makes them shorter
//     const sweepAngle = math.pi * 0.35;

//     // Re-centering the starting angles based on the shorter sweep angle
//     const leftStartAngle =
//         math.pi - (sweepAngle / 2); // Perfectly centered on the left
//     const rightStartAngle =
//         0.0 - (sweepAngle / 2); // Perfectly centered on the right

//     for (int i = 0; i < waveCount; i++) {
//       final phase = (progress + i * 0.2) % 1.0;
//       final radius =
//           baseRadius + i * radiusStep + math.sin(phase * 2 * math.pi);

//       final rect = Rect.fromCircle(center: center, radius: radius);
//       final paint = Paint()
//         ..color = color.withValues(alpha: 0.3 + 0.7 * (1 - i / waveCount))
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 1.5
//         ..strokeCap = StrokeCap.round; // Keeps the line tips rounded

//       // Left wave segment
//       canvas.drawArc(rect, leftStartAngle, sweepAngle, false, paint);
//       // Right wave segment
//       canvas.drawArc(rect, rightStartAngle, sweepAngle, false, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant _PlayWavesPainter oldDelegate) =>
//       oldDelegate.progress != progress;
// }

class _PlayWavesPainter extends CustomPainter {
  final double progress;
  static const Color color = DSColors.white;

  _PlayWavesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round;

    // 🔹 Rounded Center Triangle
    final trianglePath = Path();
    const double radius = 1.0;

    trianglePath.moveTo(center.dx - 2, center.dy - 4 + radius);
    trianglePath.lineTo(center.dx - 2, center.dy - 4);
    trianglePath.quadraticBezierTo(
      center.dx - 2,
      center.dy - 4,
      center.dx - 2 + radius,
      center.dy - 4 + radius * 0.5,
    );
    trianglePath.lineTo(center.dx + 4 - radius, center.dy - radius * 0.5);
    trianglePath.quadraticBezierTo(
      center.dx + 4,
      center.dy,
      center.dx + 4 - radius,
      center.dy + radius * 0.5,
    );
    trianglePath.lineTo(center.dx - 2 + radius, center.dy + 4 - radius * 0.5);
    trianglePath.quadraticBezierTo(
      center.dx - 2,
      center.dy + 4,
      center.dx - 2,
      center.dy + 4 - radius,
    );

    trianglePath.close();
    canvas.drawPath(trianglePath, fillPaint);

    // 🔹 Waves (Progressively Longer Arcs)
    const waveCount = 3;
    const baseRadius = 8.0;
    const radiusStep = 3.0;

    for (int i = 0; i < waveCount; i++) {
      final phase = (progress + i * 0.2) % 1.0;
      final radius =
          baseRadius + i * radiusStep + math.sin(phase * 2 * math.pi);

      // 💡 Dynamic Sweep Angle:
      // i = 0 (smallest): math.pi * 0.35 (Remains exactly how it was)
      // i = 1 (middle):   math.pi * 0.42
      // i = 2 (outermost):math.pi * 0.49 (A little longer)
      final sweepAngle = (0.35 + (i * 0.07)) * math.pi;

      // Dynamically recalculate start angles so each wave remains perfectly centered
      final leftStartAngle = math.pi - (sweepAngle / 2);
      final rightStartAngle = 0.0 - (sweepAngle / 2);

      final rect = Rect.fromCircle(center: center, radius: radius);
      final paint = Paint()
        ..color = color.withValues(alpha: 0.3 + 0.7 * (1 - i / waveCount))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round;

      // Left wave segment
      canvas.drawArc(rect, leftStartAngle, sweepAngle, false, paint);
      // Right wave segment
      canvas.drawArc(rect, rightStartAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PlayWavesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
