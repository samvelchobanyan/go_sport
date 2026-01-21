import 'package:flutter/material.dart';
import '../foundations/ds_colors.dart';
import '../foundations/ds_typography.dart';

class DSThemeData {
  static ThemeData get mainTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light, 
      scaffoldBackgroundColor: DSColors.white,
      
      colorScheme: const ColorScheme.light(
      // Primary = основной интерактив (blue)
      primary: DSColors.blue,
      onPrimary: DSColors.white,

      // Secondary = бренд-акцент (orange)
      secondary: DSColors.orange,
      onSecondary: DSColors.white,

      // Tertiary = яркий лайм (под кнопки/акцентные поверхности)
      tertiary: DSColors.lime,
      onTertiary: DSColors.black, // как ты и хотел: текст на "желтом" = черный

      surface: DSColors.white,
      onSurface: DSColors.black,

      // Dividers / strokes
      outlineVariant: DSColors.gray20,

      // Errors
      error: DSColors.errorColor,
      onError: DSColors.white,
      ),

      textTheme: const TextTheme(
        // ========================================================
        // HEADLINES (Крупные заголовки экранов и секций - Noah)
        // ========================================================
        headlineLarge: DSTypography.h1,   // 28px — Заголовки экранов (News, Home)
        headlineMedium: DSTypography.h2,  // 21px — Заголовки секций (Featured, Latest)
        headlineSmall: DSTypography.h3,   // 18px — Подзаголовки

        // ========================================================
        // TITLES (Элементы списков - Montserrat)
        // Иерархия: 14px -> 13px Bold -> 13px SemiBold
        // ========================================================
        titleLarge: DSTypography.subtitleLBold,  // 14px Bold (Названия треков, альбомов)
        titleMedium: DSTypography.subtitleMBold, // 13px Bold (Вторичный акцент)
        titleSmall: DSTypography.subtitleM,      // 13px SemiBold (Мелкий заголовок)

        // ========================================================
        // BODY (Основной контент - Montserrat)
        // ========================================================
        bodyLarge: DSTypography.subtitleLSemi, // 14px SemiBold (Вступления, акценты)
        
        // [ВАЖНО] Дефолтный стиль для всего текста в приложении
        bodyMedium: DSTypography.bodyL,        // 13px Medium (Основной текст)
        
        bodySmall: DSTypography.textL,         // 12px SemiBold (Мелкие подписи)

        // ========================================================
        // LABELS (Интерфейс и кнопки - Montserrat)
        // ========================================================
        labelLarge: DSTypography.fieldLabel,   // 11px w600 (Текст кнопок)
        labelMedium: DSTypography.label,       // 11px w500
        labelSmall: DSTypography.label,        // 11px w500
      ),

      cardTheme: CardThemeData(
        color: DSColors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      dividerTheme: const DividerThemeData(
        color: DSColors.divider,
        thickness: 1,
        space: 1,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: DSColors.white, // Лучше сделать как фон, чтобы не было шва
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0, // Чтобы при скролле AppBar не менял цвет
        iconTheme: IconThemeData(color: DSColors.black),
        titleTextStyle: DSTypography.bodyL, // Заголовок в AppBar обычно 17px SemiBold
      ),

      // Настройка нижнего меню (Material 3 NavigationBar)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: DSColors.white,
        indicatorColor: DSColors.transparent,
        elevation: 0,
        height: 69,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DSTypography.navLabel.copyWith(color: DSColors.black);
          }
          return DSTypography.navLabel.copyWith(color: DSColors.gray50);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: DSColors.black, size: 25);
          }
          return const IconThemeData(color: DSColors.gray50, size: 25);
        }),
      ),
    );
  }
}