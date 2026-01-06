import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      key: const ValueKey('privacy_page'),
      padding: const EdgeInsets.all(24),
      color: theme.colors.bgPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Privacy & security', style: theme.text.h1),
          const SizedBox(height: 16),
          Text(
            'Permissions, security settings and data protection.',
            style: theme.text.body,
          ),
        ],
      ),
    );
  }
}
