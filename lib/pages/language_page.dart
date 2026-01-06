import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      key: const ValueKey('language_page'),
      padding: const EdgeInsets.all(24),
      color: theme.colors.bgPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Time & language', style: theme.text.h1),
          const SizedBox(height: 16),
          Text(
            'Language, region, date and time settings.',
            style: theme.text.body,
          ),
        ],
      ),
    );
  }
}
