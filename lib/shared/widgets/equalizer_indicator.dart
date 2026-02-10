import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

class EqualizerIndicator extends StatefulWidget {
  final bool isPlaying;

  const EqualizerIndicator({
    super.key,
    required this.isPlaying,
  });

  @override
  State<EqualizerIndicator> createState() => _EqualizerIndicatorState();
}

class _EqualizerIndicatorState extends State<EqualizerIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    if (widget.isPlaying) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(EqualizerIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = 0;
      }
    }
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
      height: 16,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _Bar(
                height: widget.isPlaying
                    ? 4 + (_controller.value * 8)
                    : 4,
              ),
              _Bar(
                height: widget.isPlaying
                    ? 6 + ((1 - _controller.value) * 6)
                    : 6,
              ),
              _Bar(
                height: widget.isPlaying
                    ? 8 + (_controller.value * 4)
                    : 4,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;

  const _Bar({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: height,
      decoration: BoxDecoration(
        color: DSColors.blue,
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }
}
