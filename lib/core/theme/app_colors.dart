import 'package:flutter/painting.dart';

/// Цветовые токены. Виджеты берут цвета только отсюда или из `Theme`.
abstract final class AppColors {
  // Космос
  static const spaceDeep = Color(0xFF060A1C);
  static const spaceMid = Color(0xFF0D1433);
  static const spaceGlow = Color(0xFF1B2560);
  static const star = Color(0xFFE8ECFF);

  // Поверхности
  static const surface = Color(0xFF131A3A);
  static const surfaceHigh = Color(0xFF1C2550);
  static const outline = Color(0x33FFFFFF);
  static const orbitLine = Color(0x1FFFFFFF);

  // Акценты
  static const sun = Color(0xFFFFB547);
  static const onSun = Color(0xFF2A1700);
  static const mint = Color(0xFF7CF2D0);
  static const onMint = Color(0xFF00281E);

  // Текст
  static const textPrimary = Color(0xFFF2F4FF);
  static const textSecondary = Color(0xFFA6AED6);
  static const textMuted = Color(0xFF6B739C);

  // Состояния
  static const danger = Color(0xFFFF6B6B);
  static const streakCracked = Color(0xFFFF9F6B);
  static const scrim = Color(0xCC000000);

  // Заглушка превью камеры
  static const cameraGradient = [
    Color(0xFF2B1B5A),
    Color(0xFF6A2C70),
    Color(0xFFB83B5E),
    Color(0xFFF08A5D),
  ];

  // Заглушка просмотра снапа / момента
  static const viewerGradient = [
    Color(0xFF0F2A5C),
    Color(0xFF1F6E8C),
    Color(0xFF7CF2D0),
  ];
}
