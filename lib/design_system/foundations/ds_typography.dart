import 'package:flutter/material.dart';
import 'ds_colors.dart';

class DSTypography {
  // Заголовок в плеере и названия разделов (Music, Radio)
  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: DSColors.textMain,
    letterSpacing: -0.5,
  );

  // Названия треков в списках и подзаголовки
  static const TextStyle bodyL = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: DSColors.textMain,
    letterSpacing: -0.4,
  );

  // Имя артиста, название программы в расписании
  static const TextStyle bodyM = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: DSColors.textMain,
  );

  // Вторичный текст (время, длительность, мелкие подписи)
  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: DSColors.textGrey,
  );

  // Стили для ярлыков (например, "Started" в расписании или кнопка напоминания)
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: DSColors.primary,
    letterSpacing: 0.5,
  );
}