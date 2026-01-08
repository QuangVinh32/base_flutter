import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return SizedBox.expand(child: Container(
      key: const ValueKey('home_page'),
      padding: const EdgeInsets.all(24),
      color: theme.colors.bgSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Home',
            style: theme.text.h1,
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome to the Home settings page.',
            style: theme.text.body,
          ),
        ],
      ),
    )); 
  }
}
