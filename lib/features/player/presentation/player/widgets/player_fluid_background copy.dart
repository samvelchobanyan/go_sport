import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../blob_sdf_loader.dart';

class PlayerFluidBackground extends StatefulWidget {
  const PlayerFluidBackground({
    super.key,
    required this.colors, // 12 цветов: (A0,B0, A1,B1, ... A5,B5)
    this.alpha = 0.5,
    this.blur = 0.06,
    this.segmentDuration = const Duration(milliseconds: 3000),
  }) : assert(colors.length == 12, 'colors must be 12 items: A0,B0..A5,B5');

  final List<Color> colors;
  final double alpha;
  final double blur;
  final Duration segmentDuration;

  @override
  State<PlayerFluidBackground> createState() => _PlayerFluidBackgroundState();
}

class _PlayerFluidBackgroundState extends State<PlayerFluidBackground>
    with SingleTickerProviderStateMixin {
  ui.FragmentProgram? _program;
  List<BlobSdfSet>? _blobs;

  late final Ticker _ticker;
  Duration _last = Duration.zero;

  int _i = 0;      // current state 0..5
  double _t = 0.0; // raw progress 0..1

  @override
  void initState() {
    super.initState();
    _init();

    _ticker = createTicker((elapsed) {
      if (_last == Duration.zero) {
        _last = elapsed;
        return;
      }

      final dt = elapsed - _last;
      _last = elapsed;

      final segMicros = widget.segmentDuration.inMicroseconds.toDouble();
      final add = dt.inMicroseconds / segMicros;

      double t = _t + add;
      int i = _i;

      while (t >= 1.0) {
        t -= 1.0;
        i = (i + 1) % 6;
      }

      setState(() {
        _i = i;
        _t = t;
      });
    })..start();
  }

  Future<void> _init() async {
    final program = await ui.FragmentProgram.fromAsset(
      'lib/features/player/presentation/player/shaders/blob.frag',
    );
    final blobs = await BlobSdfLoader.loadAll();

    if (!mounted) return;
    setState(() {
      _program = program;
      _blobs = blobs;
    });
  }

  static double _smoothstep(double x) {
    final t = x.clamp(0.0, 1.0);
    return t * t * (3.0 - 2.0 * t);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final program = _program;
    final blobs = _blobs;

    if (program == null || blobs == null) {
      return const SizedBox.expand();
    }

    final a = widget.colors[_i * 2];
    final b = widget.colors[_i * 2 + 1];
    final c = _mixColor(a, b, 0.5); // пересечение: пока авто (среднее)

    return CustomPaint(
      painter: _BlobPainter(
        program: program,
        blobs: blobs,
        i: _i,
        t: _smoothstep(_t),
        blur: widget.blur,
        alpha: widget.alpha,
        colorA: a,
        colorB: b,
        colorC: c,
      ),
      child: const SizedBox.expand(),
    );
  }

  static Color _mixColor(Color a, Color b, double t) {
    int mix(int x, int y) => (x + (y - x) * t).round();
    return Color.fromARGB(
      mix(a.alpha, b.alpha),
      mix(a.red, b.red),
      mix(a.green, b.green),
      mix(a.blue, b.blue),
    );
  }
}

class _BlobPainter extends CustomPainter {
  _BlobPainter({
    required this.program,
    required this.blobs,
    required this.i,
    required this.t,
    required this.blur,
    required this.alpha,
    required this.colorA,
    required this.colorB,
    required this.colorC,
  });

  final ui.FragmentProgram program;
  final List<BlobSdfSet> blobs;

  final int i;
  final double t;

  final double blur;
  final double alpha;

  final Color colorA;
  final Color colorB;
  final Color colorC;

  @override
  void paint(Canvas canvas, Size size) {
    final next = (i + 1) % 6;

    final shader = program.fragmentShader();

    int f = 0;

    // uSize
    shader.setFloat(f++, size.width);
    shader.setFloat(f++, size.height);

    // uProgress, uBlur, uAlpha
    shader.setFloat(f++, t.toDouble());
    shader.setFloat(f++, blur);
    shader.setFloat(f++, alpha);

    void setColor(Color c) {
      shader.setFloat(f++, c.red / 255.0);
      shader.setFloat(f++, c.green / 255.0);
      shader.setFloat(f++, c.blue / 255.0);
    }

    // uColorA, uColorB, uColorC
    setColor(colorA);
    setColor(colorB);
    setColor(colorC);

    // samplers (must match blob.frag)
    shader.setImageSampler(0, blobs[i].shape1);
    shader.setImageSampler(1, blobs[next].shape1);
    shader.setImageSampler(2, blobs[i].shape2);
    shader.setImageSampler(3, blobs[next].shape2);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _BlobPainter old) {
    return old.i != i ||
        old.t != t ||
        old.blur != blur ||
        old.alpha != alpha ||
        old.colorA != colorA ||
        old.colorB != colorB ||
        old.colorC != colorC ||
        old.blobs != blobs;
  }
}
