import 'package:flutter/material.dart';
import '../foundations/ds_colors.dart';
import '../foundations/ds_typography.dart';

class DSThemeData {
  static ThemeData get mainTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light, 
      scaffoldBackgroundColor: DSColors.background,
      
      colorScheme: const ColorScheme.light(
        primary: DSColors.primary,
        onPrimary: DSColors.black, // Текст на желтых кнопках будет черным
        surface: DSColors.surface,
        onSurface: DSColors.textMain,
        secondary: DSColors.accentBlue,
        outlineVariant: DSColors.divider, // Цвет для разделителей
      ),

      textTheme: const TextTheme(
        displayLarge: DSTypography.h1,
        headlineMedium: DSTypography.h2,   // Добавили наш h2
        bodyLarge: DSTypography.bodyL,
        bodyMedium: DSTypography.bodyM,
        labelLarge: DSTypography.label,    // Добавили наш bold label
        labelSmall: DSTypography.caption,
      ),

      cardTheme: CardThemeData(
        color: DSColors.surface,
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
        backgroundColor: DSColors.background, // Лучше сделать как фон, чтобы не было шва
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0, // Чтобы при скролле AppBar не менял цвет
        iconTheme: IconThemeData(color: DSColors.textMain),
        titleTextStyle: DSTypography.bodyL, // Заголовок в AppBar обычно 17px SemiBold
      ),

      // Настройка нижнего меню (визуально как на макете)
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: DSColors.surface,
        selectedItemColor: DSColors.textMain,
        unselectedItemColor: DSColors.textGrey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}