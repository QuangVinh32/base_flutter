import 'package:flutter/material.dart';
import 'package:shop_food_app/layout/setting_layout.dart';
import 'package:shop_food_app/pages_app/setting_layout_app.dart';
import 'package:shop_food_app/theme/app_colors.dart';
import 'package:shop_food_app/theme/app_theme.dart';


void main() {
  runApp(AppTheme(colors: AppColors.tet, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const SettingLayoutApp(),
    );
  }
}

