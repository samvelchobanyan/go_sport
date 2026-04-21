import 'package:flutter/material.dart';

class DSWaveIcon extends StatefulWidget {
  final Color color;
  final double size;
  final bool isAnimated;

  const DSWaveIcon({
    super.key,
    required this.color,
    this.size = 24.0,
    this.isAnimated = false,
  });

  @override
  State<DSWaveIcon> createState() => _DSWaveIconState();
}

class _DSWaveIconState extends State<DSWaveIcon>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant DSWaveIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimated != oldWidget.isAnimated) {
      _initAnimation();
    }
  }

  void _initAnimation() {
    if (widget.isAnimated) {
      _controller ??= AnimationController(
        duration: const Duration(milliseconds: 2000),
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
  Widget build(BuildContext context) {
    if (_controller != null) {
      return AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _WaveIconPainter(
              color: widget.color,
              animationValue: _controller!.value,
            ),
          );
        },
      );
    }

    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: _WaveIconPainter(
        color: widget.color,
        animationValue: null,
      ),
    );
  }
}

class _WaveIconPainter extends CustomPainter {
  final Color color;
  final double? animationValue;

  _WaveIconPainter({required this.color, this.animationValue});

  double _getWaveOpacity(double phase) {
    if (animationValue == null) return 1.0;
    final wave = (animationValue! + phase) % 1.0;
    return (wave < 0.5) ? wave * 2 : (1.0 - wave) * 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Apply circular clipping (rx="12" means circular)
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(size.width / 2),
      ),
    );

    // Scale factor: viewBox is 24x24, but coordinates extend from -3 to 27
    // We need to scale and offset to fit within the 24x24 space
    final scale = size.width / 24.0;
    final offset = 3.0 * scale; // Offset for negative coordinates

    // Path 1: Outermost left wave
    final path1 = Path();
    path1.moveTo((0.506941 + 3) * scale, (3.25039 + 3) * scale - offset);
    path1.cubicTo(
      (0.832607 + 3) * scale, (2.91581 + 3) * scale - offset,
      (1.36019 + 3) * scale, (2.91671 + 3) * scale - offset,
      (1.68514 + 3) * scale, (3.25206 + 3) * scale - offset,
    );
    path1.cubicTo(
      (2.0102 + 3) * scale, (3.58778 + 3) * scale - offset,
      (2.00923 + 3) * scale, (4.13139 + 3) * scale - offset,
      (1.68352 + 3) * scale, (4.46643 + 3) * scale - offset,
    );
    path1.cubicTo(
      (-0.181271 + 3) * scale, (6.38466 + 3) * scale - offset,
      (-1.33359 + 3) * scale, (9.03519 + 3) * scale - offset,
      (-1.33359 + 3) * scale, (11.9639 + 3) * scale - offset,
    );
    path1.cubicTo(
      (-1.33353 + 3) * scale, (14.9269 + 3) * scale - offset,
      (-0.153076 + 3) * scale, (17.6036 + 3) * scale - offset,
      (1.75024 + 3) * scale, (19.5269 + 3) * scale - offset,
    );
    path1.cubicTo(
      (2.07884 + 3) * scale, (19.8589 + 3) * scale - offset,
      (2.08377 + 3) * scale, (20.4042 + 3) * scale - offset,
      (1.76163 + 3) * scale, (20.7429 + 3) * scale - offset,
    );
    path1.cubicTo(
      (1.43957 + 3) * scale, (21.0811 + 3) * scale - offset,
      (0.911932 + 3) * scale, (21.0863 + 3) * scale - offset,
      (0.583427 + 3) * scale, (20.7546 + 3) * scale - offset,
    );
    path1.cubicTo(
      (-1.62655 + 3) * scale, (18.5218 + 3) * scale - offset,
      (-2.99994 + 3) * scale, (15.4071 + 3) * scale - offset,
      (-3 + 3) * scale, (11.9639 + 3) * scale - offset,
    );
    path1.cubicTo(
      (-3 + 3) * scale, (8.5607 + 3) * scale - offset,
      (-1.6583 + 3) * scale, (5.47764 + 3) * scale - offset,
      (0.506941 + 3) * scale, (3.25039 + 3) * scale - offset,
    );
    path1.close();

    // Path 2: Second left wave
    final path2 = Path();
    path2.moveTo(4.40625 * scale, 4.21867 * scale);
    path2.cubicTo(4.6994 * scale, 3.92648 * scale, 5.1743 * scale, 3.92726 * scale, 5.4668 * scale, 4.22014 * scale);
    path2.cubicTo(5.7594 * scale, 4.51333 * scale, 5.75852 * scale, 4.98808 * scale, 5.46533 * scale, 5.28068 * scale);
    path2.cubicTo(3.78676 * scale, 6.95595 * scale, 2.74951 * scale, 9.27075 * scale, 2.74951 * scale, 11.8285 * scale);
    path2.cubicTo(2.74957 * scale, 14.4162 * scale, 3.81214 * scale, 16.7539 * scale, 5.52539 * scale, 18.4335 * scale);
    path2.cubicTo(5.82118 * scale, 18.7235 * scale, 5.82561 * scale, 19.1997 * scale, 5.53564 * scale, 19.4955 * scale);
    path2.cubicTo(5.24575 * scale, 19.7909 * scale, 4.7708 * scale, 19.7954 * scale, 4.4751 * scale, 19.5058 * scale);
    path2.cubicTo(2.48581 * scale, 17.5557 * scale, 1.24957 * scale, 14.8356 * scale, 1.24951 * scale, 11.8285 * scale);
    path2.cubicTo(1.24951 * scale, 8.85637 * scale, 2.45723 * scale, 6.16381 * scale, 4.40625 * scale, 4.21867 * scale);
    path2.close();

    // Path 3: Third left wave
    final path3 = Path();
    path3.moveTo(7.24951 * scale, 7.28024 * scale);
    path3.cubicTo(7.55177 * scale, 6.99785 * scale, 8.02565 * scale, 7.01371 * scale, 8.30859 * scale, 7.3154 * scale);
    path3.cubicTo(8.59162 * scale, 7.61784 * scale, 8.57588 * scale, 8.09291 * scale, 8.27344 * scale, 8.37594 * scale);
    path3.cubicTo(7.32471 * scale, 9.26391 * scale, 6.75 * scale, 10.4791 * scale, 6.75 * scale, 11.811 * scale);
    path3.cubicTo(6.75012 * scale, 13.1583 * scale, 7.33836 * scale, 14.3863 * scale, 8.30713 * scale, 15.2768 * scale);
    path3.cubicTo(8.61198 * scale, 15.5571 * scale, 8.63264 * scale, 16.0309 * scale, 8.35254 * scale, 16.3359 * scale);
    path3.cubicTo(8.07223 * scale, 16.6408 * scale, 7.59694 * scale, 16.6601 * scale, 7.29199 * scale, 16.3799 * scale);
    path3.cubicTo(6.03968 * scale, 15.2284 * scale, 5.25012 * scale, 13.6107 * scale, 5.25 * scale, 11.811 * scale);
    path3.cubicTo(5.25 * scale, 10.0318 * scale, 6.02183 * scale, 8.4291 * scale, 7.24951 * scale, 7.28024 * scale);
    path3.close();

    // Path 4: Center speaker
    final path4 = Path();
    path4.moveTo(10.5439 * scale, 8.93982 * scale);
    path4.cubicTo(10.9445 * scale, 8.66958 * scale, 11.3924 * scale, 8.91381 * scale, 12.2856 * scale, 9.40271 * scale);
    path4.cubicTo(12.5175 * scale, 9.52955 * scale, 12.7413 * scale, 9.66012 * scale, 12.939 * scale, 9.78504 * scale);
    path4.cubicTo(13.1642 * scale, 9.92741 * scale, 13.4098 * scale, 10.0987 * scale, 13.6567 * scale, 10.2802 * scale);
    path4.cubicTo(14.5521 * scale, 10.9375 * scale, 15 * scale, 11.2661 * scale, 15 * scale, 11.8285 * scale);
    path4.cubicTo(14.9999 * scale, 12.3907 * scale, 14.5522 * scale, 12.7194 * scale, 13.6567 * scale, 13.3768 * scale);
    path4.cubicTo(13.4097 * scale, 13.5582 * scale, 13.1642 * scale, 13.7295 * scale, 12.939 * scale, 13.872 * scale);
    path4.cubicTo(12.7415 * scale, 13.9967 * scale, 12.5173 * scale, 14.126 * scale, 12.2856 * scale, 14.2528 * scale);
    path4.cubicTo(11.392 * scale, 14.7419 * scale, 10.9446 * scale, 14.9864 * scale, 10.5439 * scale, 14.7157 * scale);
    path4.cubicTo(10.1433 * scale, 14.4449 * scale, 10.107 * scale, 13.8787 * scale, 10.0342 * scale, 12.7455 * scale);
    path4.cubicTo(10.0136 * scale, 12.4249 * scale, 10.0005 * scale, 12.1102 * scale, 10.0005 * scale, 11.8285 * scale);
    path4.cubicTo(10.0005 * scale, 11.5467 * scale, 10.0136 * scale, 11.2321 * scale, 10.0342 * scale, 10.9115 * scale);
    path4.cubicTo(10.107 * scale, 9.77806 * scale, 10.1432 * scale, 9.21056 * scale, 10.5439 * scale, 8.93982 * scale);
    path4.close();

    // Path 5: Third right wave
    final path5 = Path();
    path5.moveTo(15.7424 * scale, 7.35341 * scale);
    path5.cubicTo(16.0287 * scale, 7.05429 * scale, 16.5036 * scale, 7.04393 * scale, 16.803 * scale, 7.32997 * scale);
    path5.cubicTo(18.0002 * scale, 8.4751 * scale, 18.7498 * scale, 10.0573 * scale, 18.7498 * scale, 11.8109 * scale);
    path5.cubicTo(18.7496 * scale, 13.5853 * scale, 17.9824 * scale, 15.1833 * scale, 16.7605 * scale, 16.3314 * scale);
    path5.cubicTo(16.4587 * scale, 16.6151 * scale, 15.9836 * scale, 16.5996 * scale, 15.7 * scale, 16.2977 * scale);
    path5.cubicTo(15.4167 * scale, 15.9958 * scale, 15.432 * scale, 15.5222 * scale, 15.7337 * scale, 15.2387 * scale);
    path5.cubicTo(16.678 * scale, 14.3514 * scale, 17.2496 * scale, 13.1393 * scale, 17.2498 * scale, 11.8109 * scale);
    path5.cubicTo(17.2498 * scale, 10.4979 * scale, 16.6906 * scale, 9.29843 * scale, 15.7659 * scale, 8.41396 * scale);
    path5.cubicTo(15.4669 * scale, 8.12762 * scale, 15.4562 * scale, 7.65263 * scale, 15.7424 * scale, 7.35341 * scale);
    path5.close();

    // Path 6: Second right wave
    final path6 = Path();
    path6.moveTo(18.6166 * scale, 4.29342 * scale);
    path6.cubicTo(18.9124 * scale, 4.00345 * scale, 19.3871 * scale, 4.00789 * scale, 19.6771 * scale, 4.30368 * scale);
    path6.cubicTo(21.5771 * scale, 6.24192 * scale, 22.7504 * scale, 8.89915 * scale, 22.7504 * scale, 11.8286 * scale);
    path6.cubicTo(22.7503 * scale, 14.793 * scale, 21.5484 * scale, 17.4785 * scale, 19.6083 * scale, 19.4223 * scale);
    path6.cubicTo(19.3157 * scale, 19.7151 * scale, 18.8407 * scale, 19.7163 * scale, 18.5478 * scale, 19.4238 * scale);
    path6.cubicTo(18.2546 * scale, 19.1312 * scale, 18.2552 * scale, 18.6564 * scale, 18.5478 * scale, 18.3632 * scale);
    path6.cubicTo(20.2186 * scale, 16.6891 * scale, 21.2503 * scale, 14.3797 * scale, 21.2504 * scale, 11.8286 * scale);
    path6.cubicTo(21.2504 * scale, 9.30758 * scale, 20.2423 * scale, 7.02316 * scale, 18.6063 * scale, 5.35397 * scale);
    path6.cubicTo(18.3164 * scale, 5.05823 * scale, 18.3209 * scale, 4.58341 * scale, 18.6166 * scale, 4.29342 * scale);
    path6.close();

    // Path 7: Outermost right wave
    final path7 = Path();
    path7.moveTo(22.3262 * scale, 3.24816 * scale);
    path7.cubicTo(22.6606 * scale, 2.91279 * scale, 23.1974 * scale, 2.91792 * scale, 23.5253 * scale, 3.26001 * scale);
    path7.cubicTo(25.6734 * scale, 5.50166 * scale, 27 * scale, 8.57485 * scale, 27 * scale, 11.9629 * scale);
    path7.cubicTo(26.9999 * scale, 15.3913 * scale, 25.6409 * scale, 18.4972 * scale, 23.4474 * scale, 20.7453 * scale);
    path7.cubicTo(23.1166 * scale, 21.084 * scale, 22.5796 * scale, 21.0853 * scale, 22.2483 * scale, 20.747 * scale);
    path7.cubicTo(21.9169 * scale, 20.4086 * scale, 21.9176 * scale, 19.8595 * scale, 22.2483 * scale, 19.5204 * scale);
    path7.cubicTo(24.1375 * scale, 17.5842 * scale, 25.304 * scale, 14.9133 * scale, 25.304 * scale, 11.9629 * scale);
    path7.cubicTo(25.304 * scale, 9.04722 * scale, 24.1643 * scale, 6.40519 * scale, 22.3146 * scale, 4.47472 * scale);
    path7.cubicTo(21.9867 * scale, 4.13268 * scale, 21.9919 * scale, 3.58353 * scale, 22.3262 * scale, 3.24816 * scale);
    path7.close();

    // Path 1 (outermost left): phase = 0.0
    paint.color = color.withValues(alpha: _getWaveOpacity(0.0));
    canvas.drawPath(path1, paint);

    // Path 2 (second left): phase = 0.15
    paint.color = color.withValues(alpha: _getWaveOpacity(0.15));
    canvas.drawPath(path2, paint);

    // Path 3 (third left): phase = 0.3
    paint.color = color.withValues(alpha: _getWaveOpacity(0.3));
    canvas.drawPath(path3, paint);

    // Path 4 (center speaker): NO animation
    paint.color = color;
    canvas.drawPath(path4, paint);

    // Path 5 (third right): phase = 0.3
    paint.color = color.withValues(alpha: _getWaveOpacity(0.3));
    canvas.drawPath(path5, paint);

    // Path 6 (second right): phase = 0.15
    paint.color = color.withValues(alpha: _getWaveOpacity(0.15));
    canvas.drawPath(path6, paint);

    // Path 7 (outermost right): phase = 0.0
    paint.color = color.withValues(alpha: _getWaveOpacity(0.0));
    canvas.drawPath(path7, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_WaveIconPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue;
  }
}
