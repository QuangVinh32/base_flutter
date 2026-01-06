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

  /// Light
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

    accent: Color(0xFF3B82F6),
    accentHover: Color.fromARGB(255, 235, 60, 197),
    error: Color(0xFFF87171),
  );
}
