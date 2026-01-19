import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

/// Заголовок секции с опциональным анимированным эквалайзером
class WaveSectionHeader extends StatelessWidget {
  final String title;
  final bool showAnimation;

  const WaveSectionHeader({
    super.key,
    required this.title,
    this.showAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            title,
            style: context.h2,
          ),
          if (showAnimation) ...[
            const SizedBox(width: 5),
            const AnimatedEqualizer(),
          ],
        ],
      ),
    );
  }
}

/// Анимированный эквалайзер (5 эллипсов)
class AnimatedEqualizer extends StatefulWidget {
  const AnimatedEqualizer({super.key});

  @override
  State<AnimatedEqualizer> createState() => _AnimatedEqualizerState();
}

class _AnimatedEqualizerState extends State<AnimatedEqualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Параметры эллипсов из Figma
  static const _ellipses = [
    _EllipseData(width: 2.95, maxHeight: 17.0, minHeight: 5.0, left: 2.0),
    _EllipseData(width: 2.45, maxHeight: 15.93, minHeight: 4.7, left: 5.26),
    _EllipseData(width: 1.83, maxHeight: 14.06, minHeight: 4.2, left: 8.31),
    _EllipseData(width: 1.22, maxHeight: 10.38, minHeight: 3.1, left: 10.96),
    _EllipseData(width: 0.59, maxHeight: 5.05, minHeight: 1.5, left: 13.41),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
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
      width: 16,
      height: 17,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _EqualizerPainter(
              progress: _controller.value,
              ellipses: _ellipses,
            ),
          );
        },
      ),
    );
  }
}

/// Данные одного эллипса
class _EllipseData {
  final double width;
  final double maxHeight;
  final double minHeight;
  final double left;

  const _EllipseData({
    required this.width,
    required this.maxHeight,
    required this.minHeight,
    required this.left,
  });
}

/// Painter для рисования анимированных эллипсов
class _EqualizerPainter extends CustomPainter {
  final double progress;
  final List<_EllipseData> ellipses;
  
  static const _color = DSColors.orange;

  _EqualizerPainter({
    required this.progress,
    required this.ellipses,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < ellipses.length; i++) {
      final ellipse = ellipses[i];
      
      // Сдвиг фазы для каждого эллипса (волновой эффект)
      final phase = (progress + (i * 0.2)) % 1.0;
      
      // Высота изменяется синусоидально от min до max
      final height = ellipse.minHeight +
          (ellipse.maxHeight - ellipse.minHeight) *
              (0.5 + 0.5 * Math.sin(phase * 2 * Math.pi));

      // Рисуем эллипс
      final rect = Rect.fromLTWH(
        ellipse.left,
        size.height - height, // Выравниваем по низу
        ellipse.width,
        height,
      );

      canvas.drawOval(rect, paint);
    }
  }

  @override
  bool shouldRepaint(_EqualizerPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SizedBox(height: 20),
          WaveSectionHeader(
            title: 'Featured playlists',
            showAnimation: true,
          ),
          SizedBox(height: 20),
          WaveSectionHeader(
            title: 'Recent tracks',
            showAnimation: false,
          ),
        ],
      ),
    );
  }
}