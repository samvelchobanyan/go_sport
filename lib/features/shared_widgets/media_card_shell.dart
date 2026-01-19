import 'package:flutter/material.dart';

class MediaCardShell extends StatelessWidget {
  final Widget child;
  final double aspectRatio;

  const MediaCardShell({
    super.key,
    required this.child,
    this.aspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Радиус из CardTheme
        ),
        child: child,
      ),
    );
  }
}