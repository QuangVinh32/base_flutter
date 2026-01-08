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
    bgPrimary: Color(0xFFF5F5F5),
    bgSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFFF0F0F0),
    border: Color(0xFFE0E0E0),

    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF616161),
    textDisabled: Color(0xFF9E9E9E),

    accent: Color.fromARGB(255, 30, 177, 16),
    accentHover: Color.fromARGB(255, 30, 177, 16),
    error: Color(0xFFDC2626),
  );

  /// Dark
  static const dark = AppColors(
    bgPrimary: Color(0xFF1E1E1E),
    bgSecondary: Color(0xFF202020),
    surface: Color(0xFF2A2A2A),
    border: Color(0xFF2F2F2F),

    textPrimary: Color(0xFFEDEDED),
    textSecondary: Color(0xFFB3B3B3),
    textDisabled: Color(0xFF6B6B6B),

    accent: Color.fromARGB(255, 34, 84, 164),
    accentHover: Color.fromARGB(255, 34, 84, 164),
    error: Color(0xFFDC2626),
  );

  static const tet = AppColors(
    bgPrimary: Color(0xFFFFF5F5), // nền hồng nhạt
    bgSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFFFFE4E6), // đỏ nhạt
    border: Color(0xFFFECACA),

    textPrimary: Color(0xFF7F1D1D), // đỏ sẫm
    textSecondary: Color(0xFF991B1B),
    textDisabled: Color(0xFFB91C1C),

    accent: Color(0xFFD4AF37), // vàng kim
    accentHover: Color(0xFFFFD700), // vàng tươi
    error: Color(0xFFDC2626),
  );
}
