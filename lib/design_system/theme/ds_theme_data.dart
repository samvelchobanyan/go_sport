import 'package:flutter/material.dart';
import '../foundations/ds_colors.dart';
import '../foundations/ds_typography.dart';

class DSThemeData {
  static ThemeData get mainTheme {
    return ThemeData(
      useMaterial3: true,
      // 1. Устанавливаем светлый режим (текст станет темным, системные иконки — черными)
      brightness: Brightness.light, 
      
      // 2. Фон теперь берется из светлой палитры
      scaffoldBackgroundColor: DSColors.background,
      
      // 3. Используем светлую схему цветов
      colorScheme: const ColorScheme.light(
        primary: DSColors.primary,
        surface: DSColors.surface,
        onSurface: DSColors.textMain, // Основной текст будет темным
      ),

      // 4. Шрифты (они теперь автоматически будут темными на светлом фоне)
      textTheme: const TextTheme(
        displayLarge: DSTypography.h1,
        bodyLarge: DSTypography.bodyL,
        bodyMedium: DSTypography.bodyM,
        labelSmall: DSTypography.caption,
      ),

      // 5. Карточки (как в расписании и списках)
      cardTheme: CardThemeData(
        color: DSColors.surface, // Белый или светло-серый
        elevation: 0,            // Плоский дизайн как на макетах
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Скругление чуть больше, для мягкости
        ),
      ),
      
      // Добавляем стиль для AppBar (шапки)
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: DSColors.textMain),
      ),
    );
  }
}