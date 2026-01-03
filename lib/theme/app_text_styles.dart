import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppText {
  final AppColors colors;

  AppText(this.colors);

  TextStyle get h1 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: colors.textPrimary,
      );

  TextStyle get h2 => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      );

  TextStyle get body => TextStyle(
        fontSize: 14,
        color: colors.textPrimary,
      );

  TextStyle get caption => TextStyle(
        fontSize: 12,
        color: colors.textSecondary,
      );

  TextStyle get disabled => TextStyle(
        fontSize: 14,
        color: colors.textDisabled,
      );
}
