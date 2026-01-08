import 'package:flutter/material.dart';

@immutable
class AppColors {
  final Color bgPrimary;
  final Color bgSecondary;
  final Color surface;
  final Color border;

  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;

  final Color accent;
  final Color accentHover;
  final Color error;

  const AppColors({
    required this.bgPrimary,
    required this.bgSecondary,
    required this.surface,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.accent,
    required this.accentHover,
    required this.error,
  });

  static const light = AppColors(
    // Backgrounds
    bgPrimary: Color(0xFFF2F2F7), // iOS system background
    bgSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFFF9F9FB),
    border: Color(0xFFD1D1D6),

    // Text
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF3C3C43), // iOS secondary label
    textDisabled: Color(0xFFAEAEB2),

    // Accent
    accent: Color(0xFF007AFF), // iOS blue
    accentHover: Color(0xFF005FCC),
    error: Color(0xFFFF3B30), // iOS red
  );

  static const dark = AppColors(
    // Backgrounds
    bgPrimary: Color(0xFF000000), // true black (OLED)
    bgSecondary: Color(0xFF1C1C1E),
    surface: Color(0xFF2C2C2E),
    border: Color(0xFF38383A),

    // Text
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFEBEBF5),
    textDisabled: Color(0xFF8E8E93),

    // Accent
    accent: Color(0xFF0A84FF), // iOS blue dark
    accentHover: Color(0xFF409CFF),
    error: Color(0xFFFF453A),
  );

  static const tet = AppColors(
    bgPrimary: Color(0xFFFFF5F5), // nền hồng nhạt
    bgSecondary: Color(0xFF991B1B),
    surface: Color(0xFFFFE4E6), // đỏ nhạt
    border: Color(0xFFFECACA),

    textPrimary: Color(0xFFFFFFFF), // đỏ sẫm
    textSecondary: Color(0xFF991B1B),
    textDisabled: Color(0xFFFFF5F5),

    accent: Color(0xFFD4AF37), // vàng kim
    accentHover: Color(0xFFFFD700), // vàng tươi
    error: Color(0xFFDC2626),
  );
}
