import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedGradientBlobs extends StatefulWidget {
  const AnimatedGradientBlobs({
    super.key,
    this.duration = const Duration(milliseconds: 2500), // Чуть медленнее для плавности
    this.hold = const Duration(milliseconds: 500),
    this.blurSigma = 90.0, // Оптимальное значение для баланса красоты и скорости
  });

  final Duration duration;
  final Duration hold;
  final double blurSigma;

  @override
  State<AnimatedGradientBlobs> createState() => _AnimatedGradientBlobsState();
}

class _AnimatedGradientBlobsState extends State<AnimatedGradientBlobs>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  int _from = 0;
  int _to = 1;

  // Ваши цвета и пресеты из Figma
  final List<_Preset> _presets = const [
    _Preset(
      base: Color(0xFFF6F5FF),
      blobs: [
        _Blob(alignment: Alignment(-1.2, -0.9), size: 1000, color: Color(0xFF404AC3), opacity: 0.45, scaleY: 1.6),
        _Blob(alignment: Alignment(1.2, 0.9), size: 900, color: Color(0xFF441BBF), opacity: 0.45, scaleY: 1.6),
      ],
    ),
    _Preset(
      base: Color(0xFFF7F6FF),
      blobs: [
        _Blob(alignment: Alignment(-1.25, -0.85), size: 1000, color: Color(0xFF441BBF), opacity: 0.4, scaleY: 1.7),
        _Blob(alignment: Alignment(1.1, 0.95), size: 900, color: Color(0xFFFF7A5C), opacity: 0.25, scaleY: 1.5),
        _Blob(alignment: Alignment(1.3, -0.15), size: 850, color: Color(0xFF404AC3), opacity: 0.25, scaleY: 1.4),
      ],
    ),
    // Можно добавить остальные пресеты сюда
  ];

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration);
    _startAnimation();
  }

  void _startAnimation() async {
    while (mounted) {
      await _c.forward(from: 0);
      await Future.delayed(widget.hold);
      if (!mounted) return;
      setState(() {
        _from = _to;
        _to = (_to + 1) % _presets.length;
      });
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = _presets[_from];
    final b = _presets[_to];

    return RepaintBoundary( // Изолирует тяжелую графику фона от интерфейса плеера
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) {
            final t = _c.value;
            final currentBase = Color.lerp(a.base, b.base, t) ?? a.base;

            return Stack(
              fit: StackFit.expand,
              children: [
                Container(color: currentBase),
                // Рисуем пятна
                ...List.generate(
                  _max(a.blobs.length, b.blobs.length),
                  (i) => _buildBlob(i, a, b, t),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBlob(int i, _Preset fromP, _Preset toP, double t) {
    final start = i < fromP.blobs.length ? fromP.blobs[i] : const _Blob.empty();
    final end = i < toP.blobs.length ? toP.blobs[i] : const _Blob.empty();

    if (start.size == 0 && end.size == 0) return const SizedBox.shrink();

    final alignment = Alignment.lerp(start.alignment, end.alignment, t)!;
    final size = lerpDouble(start.size, end.size, t)!;
    final scaleY = lerpDouble(start.scaleY, end.scaleY, t)!;
    final color = Color.lerp(start.color, end.color, t)!;
    final opacity = (start.opacity + (end.opacity - start.opacity) * t).clamp(0.0, 1.0);

    return Align(
      alignment: alignment,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: widget.blurSigma, sigmaY: widget.blurSigma),
        child: Transform.scale(
          scaleX: 1.0,
          scaleY: scaleY,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(opacity),
            ),
          ),
        ),
      ),
    );
  }

  int _max(int x, int y) => x > y ? x : y;
  double? lerpDouble(double a, double b, double t) => a + (b - a) * t;
}

// Вспомогательные классы данных
class _Preset {
  final Color base;
  final List<_Blob> blobs;
  const _Preset({required this.base, required this.blobs});
}

class _Blob {
  final Alignment alignment;
  final double size;
  final Color color;
  final double opacity;
  final double scaleY;

  const _Blob({
    required this.alignment,
    required this.size,
    required this.color,
    required this.opacity,
    this.scaleY = 1.0,
  });

  const _Blob.empty()
      : alignment = Alignment.center,
        size = 0,
        color = Colors.transparent,
        opacity = 0,
        scaleY = 1.0;
}