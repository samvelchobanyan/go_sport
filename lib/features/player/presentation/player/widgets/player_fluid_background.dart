import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PlayerFluidBackground extends StatefulWidget {
  final List<Color> colors;

  const PlayerFluidBackground({
    super.key,
    required this.colors,
  }) : assert(colors.length == 12, 'Нужно 12 цветов');

  @override
  State<PlayerFluidBackground> createState() => _PlayerFluidBackgroundState();
}

class _PlayerFluidBackgroundState extends State<PlayerFluidBackground> with SingleTickerProviderStateMixin {
  ui.FragmentShader? _shader;
  late Ticker _ticker;
  double _elapsed = 0;

  @override
  void initState() {
    super.initState();
    _loadShader();
    
    // Инициализация тикера
    _ticker = createTicker((elapsed) {
      if (mounted) {
        setState(() {
            double customSpeed = 1;
          _elapsed = (elapsed.inMilliseconds / 1000.0) * customSpeed;
        });
      }
    });
    
    _ticker.start();
    // debugPrint('[FLUID_DEBUG] Ticker started');
  }

  Future<void> _loadShader() async {
    try {
      final program = await ui.FragmentProgram.fromAsset(
        'lib/features/player/presentation/player/shaders/fluid_blur.frag',
      );
      setState(() {
        _shader = program.fragmentShader();
      });
      // debugPrint('[FLUID_DEBUG] Shader loaded successfully');
    } catch (e) {
      debugPrint('[FLUID_DEBUG] Error loading shader: $e');
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_shader == null) {
      return Container(color: Colors.black);
    }

    return CustomPaint(
      painter: _FluidShaderPainter(
        shader: _shader!,
        time: _elapsed,
        colors: widget.colors,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _FluidShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;
  final double time;
  final List<Color> colors;

  _FluidShaderPainter({
    required this.shader,
    required this.time,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Этот лог будет срабатывать каждый кадр. 
    // Если цифры бегут — Flutter отрисовывает анимацию.
    // debugPrint('[FLUID_DEBUG] Painting frame at time: ${time.toStringAsFixed(3)}');

    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    for (int i = 0; i < 12; i++) {
      final int offset = 3 + (i * 4);
      shader.setFloat(offset, colors[i].red / 255.0);
      shader.setFloat(offset + 1, colors[i].green / 255.0);
      shader.setFloat(offset + 2, colors[i].blue / 255.0);
      shader.setFloat(offset + 3, 1.0);
    }

    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant _FluidShaderPainter oldDelegate) {
    // Всегда true для дебага, чтобы исключить блокировку перерисовки
    return true; 
  }
}