import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PlayerFluidBackground extends StatefulWidget {
  const PlayerFluidBackground({
    super.key,
    this.secondsPerStep = 2.6,
    this.scale = 1.45,
    this.opacity = 0.5, // 50% прозрачность
  });

  final double secondsPerStep;
  final double scale;
  final double opacity;

  @override
  State<PlayerFluidBackground> createState() => _PlayerFluidBackgroundState();
}

class _PlayerFluidBackgroundState extends State<PlayerFluidBackground>
    with SingleTickerProviderStateMixin {
  ui.FragmentProgram? _program;
  late final Ticker _ticker;

  Duration _last = Duration.zero;
  double _progress = 0.0; // continuous 0..6

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

      final add = dt.inMicroseconds / 1e6 / widget.secondsPerStep;

      setState(() {
        _progress = (_progress + add) % 6.0;
      });
    })..start();
  }

  Future<void> _init() async {
    final program = await ui.FragmentProgram.fromAsset(
      'lib/features/player/presentation/player/shaders/blob.frag',
    );

    if (!mounted) return;
    setState(() => _program = program);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final program = _program;
    if (program == null) return const SizedBox.expand();

    return CustomPaint(
      painter: _ProcBlobPainter(
        program: program,
        progress: _progress,
        scale: widget.scale,
        opacity: widget.opacity.clamp(0.0, 1.0),
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _ProcBlobPainter extends CustomPainter {
  _ProcBlobPainter({
    required this.program,
    required this.progress,
    required this.scale,
    required this.opacity,
  });

  final ui.FragmentProgram program;
  final double progress;
  final double scale;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final shader = program.fragmentShader();

    // uniforms order:
    // uResolution(vec2), uProgress(float), uScale(float), uOpacity(float)
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, progress);
    shader.setFloat(3, scale);
    shader.setFloat(4, opacity);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _ProcBlobPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.scale != scale ||
        oldDelegate.opacity != opacity;
  }
}
