import 'package:flutter/material.dart';

class DSColors {
  const DSColors._();

  // Base
  static const black = Color(0xFF000000); // rgba(0,0,0,1)
  static const white = Color(0xFFFFFFFF); // rgba(255,255,255,1)

  // Brand
  // static const blue = Color(0xFF404AC3); // rgba(64,74,195,1)
  static const lime = Color(0xFFCFDC28); // rgba(207,220,40,1)

  static const errorColor = Color(0xFFFF3B30); // rgba(255,59,48,1)
  static const transparent = Colors.transparent;

  // grayscale (black with opacity)
  // gray90 = darkest, gray5 = lightest
  static const gray90 = Color(0xE6000000); // 90%
  static const gray80 = Color(0xCC000000); // 80%
  static const gray70 = Color(0xB3000000); // 70%
  static const gray60 = Color(0x99000000); // 60%
  static const gray50 = Color(0x80000000); // 50%
  static const gray40 = Color(0x66000000); // 40%
  static const gray30 = Color(0x4D000000); // 30%
  static const gray20 = Color(0x33000000); // 20%
  static const gray10 = Color(0x1A000000); // 10%
  static const gray5 = Color(0xFFF2F2F2); // 5%

  // Bluescale (Solid / Opaque against White)
  static const blue = Color(0xFF404AC3); // Base Blue (100%)
  static const blue50 = Color(0xFF9FA5E1); // 50% Opaque Tint
  static const blue30 = Color(0xFFC6C9ED); // 30% Opaque Tint
  static const blue20 = Color(0xFFD9DBF3); // 20% Opaque Tint
  static const blue10 = Color(0xFFECECFA); // 10% Opaque Tint
  static const blue5 = Color(0xFFF5F5FD); // 5% Opaque Tint

  // Orange scale
  static const orange = Color(0xFFF55F2A); // rgba(245,95,42,1)
  static const orange30 = Color(0xFFFCD3C5); // 30% Opaque Tint
  static const orange5 = Color(0xFFFEF0EB); // 5% Opaque Tint

  // White scale
  static const white90 = Color(0xE6FFFFFF); // 90% Transparency (0.9)
  static const white80 = Color(0xCCFFFFFF); // 80% Transparency (0.8)
  static const white50 = Color(0x80FFFFFF); // 50% Transparency (0.5)
  static const white20 = Color(0x33FFFFFF); // 20% Transparency (0.2)
  static const white10 = Color(0x1AFFFFFF); // 10% Transparency (0.1)

  static const divider = gray20; // rgba(245,245,247,1)

  static const List<Color> storyGradient = [
    Color(0xFF404AC3), // 404AC3 at start
    Color(0xFF404AC3), // 13% (0.13)
    Color(
      0xFFCFDC28,
    ), // 38% (0.38) - Note: added the missing 'C' for CFD28 -> CFDC28
    Color(0xFF404AC3), // 63% (0.63)
    Color(0xFF404AC3), // 404AC3 at end to complete the loop smoothly
  ];
}
