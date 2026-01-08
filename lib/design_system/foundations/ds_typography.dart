import 'package:flutter/material.dart';
import 'ds_colors.dart';

class DSTypography {
  // Крупный заголовок (например, на экране News или Home)
  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: DSColors.textMain,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // Заголовки разделов (Featured playlists, News)
  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: DSColors.textMain,
    letterSpacing: -0.4,
    height: 1.2,
  );

  // Заголовки карточек новостей, названия треков
  static const TextStyle bodyL = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: DSColors.textMain,
    letterSpacing: -0.4,
    height: 1.3,
  );

  // Основной текст, описание, имена артистов
  static const TextStyle bodyM = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: DSColors.textMain,
    height: 1.4,
  );

  // Мелкие подписи, даты, таймстампы
  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: DSColors.textGrey,
    height: 1.2,
  );

  // Стиль для кнопок и акцентных меток (теги, "Started")
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: DSColors.textMain,
    letterSpacing: 0.5,
    height: 1.0,
  );
}