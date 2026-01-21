import 'package:flutter/material.dart';

class DSColors {
  const DSColors._();

  // Base
  static const black = Color(0xFF000000); // rgba(0,0,0,1)
  static const white = Color(0xFFFFFFFF); // rgba(255,255,255,1)

  // Brand
  static const blue = Color(0xFF404AC3); // rgba(64,74,195,1)
  static const lime = Color(0xFFCFDC28); // rgba(207,220,40,1)
  static const orange = Color(0xFFF55F2A); // rgba(245,95,42,1)

  static const errorColor = Color(0xFFFF3B30); // rgba(255,59,48,1)
  static const transparent = Colors.transparent;

  // greyscale (black with opacity)
  // grey90 = darkest, grey5 = lightest
  static const grey90 = Color(0xE6000000); // 90%
  static const grey80 = Color(0xCC000000); // 80%
  static const grey70 = Color(0xB3000000); // 70%
  static const grey60 = Color(0x99000000); // 60%
  static const grey50 = Color(0x80000000); // 50%
  static const grey40 = Color(0x66000000); // 40%
  static const grey30 = Color(0x4D000000); // 30%
  static const grey20 = Color(0x33000000); // 20%
  static const grey10 = Color(0x1A000000); // 10%
  static const grey5 = Color(0x0D000000); // 5%

  static const divider = grey20; // rgba(245,245,247,1)

  static const List<Color> storyGradient = [
    Color(0xFF404AC3), // синий из Figma
    Color(0xFFCFDC28), // желто-зеленый из Figma
    Color(0xFF404AC3), // синий (замыкаем круг)
  ];
}
