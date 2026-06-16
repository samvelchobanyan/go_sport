import 'package:flutter/material.dart';

extension DSTypographyExtension on BuildContext {
  // Приватный геттер для сокращения кода внутри этого файла
  TextTheme get _text => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;

  // ============================================================
  // HEADINGS (Noah)
  // ============================================================

  /// Figma: H1 (28px) -> Mapped to headlineLarge
  TextStyle? get h1 => _text.headlineLarge;

  /// Figma: H2 (21px) -> Mapped to headlineMedium
  TextStyle? get h2 => _text.headlineMedium;

  /// Figma: H3 (18px) -> Mapped to headlineSmall
  TextStyle? get h3 => _text.headlineSmall;

  // ============================================================
  // SUBTITLES / TITLES (Montserrat)
  // ============================================================

  /// Figma: Subtitle L Bold (14px Bold) -> Mapped to titleLarge
  TextStyle? get subtitleLBold => _text.titleLarge;

  /// Figma: Subtitle M Bold (13px Bold) -> Mapped to titleMedium
  TextStyle? get subtitleMBold => _text.titleMedium;

  /// Figma: Subtitle M (13px SemiBold) -> Mapped to titleSmall
  TextStyle? get subtitleM => _text.titleSmall;

  /// Figma: Subtitle L Semi (14px SemiBold) -> Mapped to bodyLarge
  TextStyle? get subtitleLSemi => _text.bodyLarge;

  // ============================================================
  // BODY / TEXT (Montserrat)
  // ============================================================

  /// Figma: Body L (13px Medium) -> Mapped to bodyMedium (DEFAULT)
  TextStyle? get bodyL => _text.bodyMedium;

  /// Figma: Text L (12px SemiBold) -> Mapped to bodySmall
  TextStyle? get textL => _text.bodySmall;

  // ============================================================
  // LABELS (Montserrat)
  // ============================================================

  /// Figma: Field Label (11px Bold) -> Mapped to labelLarge
  TextStyle? get fieldLabel => _text.labelLarge;

  /// Figma: Label (11px Medium) -> Mapped to labelMedium
  TextStyle? get label => _text.labelMedium;

  /// Armenian title in lists / cards (14px Bold)
  // TextStyle get armSubtitleLBold => DSTypography.armSubtitleLBold;

  // /// Armenian title in lists / cards (14px SemiBold)
  // TextStyle get armSubtitleLSemi => DSTypography.armSubtitleLSemi;

  // /// Armenian secondary title (13px Bold)
  // TextStyle get armSubtitleMBold => DSTypography.armSubtitleMBold;

  // /// Armenian secondary title (13px SemiBold)
  // TextStyle get armSubtitleM => DSTypography.armSubtitleM;

  // /// Armenian body text (13px Medium)
  // TextStyle? get armBodyL => _text.armTitle;

  // /// Armenian small text (12px SemiBold)
  // TextStyle? get armTextL => _text.armText;

  // /// Armenian form label (11px Medium)
  // TextStyle get armLabel => DSTypography.armLabel;

  // /// Armenian button label (11px Bold)
  // TextStyle get armFieldLabel => DSTypography.armFieldLabel;

  // /// Armenian nav label (10px SemiBold)
  // TextStyle get armNavLabel => DSTypography.armNavLabel;
}
