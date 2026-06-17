import 'package:flutter/material.dart';
import 'ds_colors.dart';

class DSTypography {
  // Крупный заголовок (например, на экране News или Home)
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Noah',
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: DSColors.black,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // Заголовки разделов (Featured playlists, News)
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Noah',
    fontSize: 21,
    fontWeight: FontWeight.w500, // Noah Black файл с весом 500
    height: 1.19, // 25px / 21px
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'Noah',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.22,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
  );

  // ===== Subtitles =====

  static const TextStyle subtitleLBold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.29, // 18 / 14
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
    fontFamilyFallback: ['Montserratarm'],
  );

  static const TextStyle subtitleLSemi = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.29, // 18 / 14
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
    fontFamilyFallback: ['Montserratarm'],
  );

  // ===== Body / Text =====

  static const TextStyle subtitleMBold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    fontWeight: FontWeight.w700,
    height: 1.38, // 18 / 13
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
    fontFamilyFallback: ['Montserratarm'],
  );

  static const TextStyle subtitleM = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.38, // 18 / 13
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
    fontFamilyFallback: ['Montserratarm'],
  );

  static const TextStyle textL = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33, // 16 / 12
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
    fontFamilyFallback: ['Montserratarm'],
  );

  static const TextStyle bodyL = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.54, // 20 / 13
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
    fontFamilyFallback: ['Montserratarm'],
  );

  // ===== Labels =====

  static const TextStyle label = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.36, // 15 / 11
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
    fontFamilyFallback: ['Montserratarm'],
  );

  static const TextStyle fieldLabel = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.36, // 15 / 11
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
    fontFamilyFallback: ['Montserratarm'],
  );

  static const TextStyle navLabel = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.2, // 12 / 10
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: DSColors.black,
    fontFamilyFallback: ['Montserratarm'],
  );

  // Armenian font styles
  // static const TextStyle armSubtitleLBold = TextStyle(
  //   fontFamily: 'Montserratarm',
  //   fontSize: 14,
  //   fontWeight: FontWeight.w700,
  //   height: 1.29, // 18 / 14
  //   letterSpacing: 0,
  //   leadingDistribution: TextLeadingDistribution.even,
  //   color: DSColors.black,
  //   fontFamilyFallback: ['Montserrat'],
  // );

  // static const TextStyle armSubtitleLSemi = TextStyle(
  //   fontFamily: 'Montserratarm',
  //   fontSize: 14,
  //   fontWeight: FontWeight.w600,
  //   height: 1.29,
  //   letterSpacing: 0,
  //   leadingDistribution: TextLeadingDistribution.even,
  //   color: DSColors.black,
  //   fontFamilyFallback: ['Montserrat'],
  // );

  // static const TextStyle armSubtitleMBold = TextStyle(
  //   fontFamily: 'Montserratarm',
  //   fontSize: 13,
  //   fontWeight: FontWeight.w700,
  //   height: 1.38, // 18 / 13
  //   letterSpacing: 0,
  //   leadingDistribution: TextLeadingDistribution.even,
  //   color: DSColors.black,
  //   fontFamilyFallback: ['Montserrat'],
  // );

  // static const TextStyle armSubtitleM = TextStyle(
  //   fontFamily: 'Montserratarm',
  //   fontSize: 13,
  //   fontWeight: FontWeight.w600,
  //   height: 1.38,
  //   letterSpacing: 0,
  //   leadingDistribution: TextLeadingDistribution.even,
  //   color: DSColors.black,
  //   fontFamilyFallback: ['Montserrat'],
  // );

  // static const TextStyle armBodyL = TextStyle(
  //   fontFamily: 'Montserratarm',
  //   fontSize: 13,
  //   fontWeight: FontWeight.w500,
  //   height: 1.54,
  //   letterSpacing: 0,
  //   leadingDistribution: TextLeadingDistribution.even,
  //   color: DSColors.black,
  //   fontFamilyFallback: ['Montserrat'],
  // );

  // static const TextStyle armTextL = TextStyle(
  //   fontFamily: 'Montserratarm',
  //   fontSize: 12,
  //   fontWeight: FontWeight.w600,
  //   height: 1.33,
  //   letterSpacing: 0,
  //   leadingDistribution: TextLeadingDistribution.even,
  //   color: DSColors.black,
  //   fontFamilyFallback: ['Montserrat'],
  // );

  // static const TextStyle armLabel = TextStyle(
  //   fontFamily: 'Montserratarm',
  //   fontSize: 11,
  //   fontWeight: FontWeight.w500,
  //   height: 1.36,
  //   letterSpacing: 0,
  //   leadingDistribution: TextLeadingDistribution.even,
  //   color: DSColors.black,
  //   fontFamilyFallback: ['Montserrat'],
  // );

  // static const TextStyle armFieldLabel = TextStyle(
  //   fontFamily: 'Montserratarm',
  //   fontSize: 11,
  //   fontWeight: FontWeight.w600,
  //   height: 1.36,
  //   letterSpacing: 0,
  //   leadingDistribution: TextLeadingDistribution.even,
  //   color: DSColors.black,
  //   fontFamilyFallback: ['Montserrat'],
  // );

  // static const TextStyle armNavLabel = TextStyle(
  //   fontFamily: 'Montserratarm',
  //   fontSize: 10,
  //   fontWeight: FontWeight.w600,
  //   height: 1.2,
  //   letterSpacing: 0,
  //   leadingDistribution: TextLeadingDistribution.even,
  //   color: DSColors.black,
  //   fontFamilyFallback: ['Montserrat'],
  // );
}
