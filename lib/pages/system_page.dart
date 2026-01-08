import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class SystemPage extends StatelessWidget {
  const SystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return SizedBox.expand(child: Container(
      key: const ValueKey('system_page'),
      padding: const EdgeInsets.all(24),
      color: theme.colors.bgSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System',
            style: theme.text.h1,
          ),
          const SizedBox(height: 16),
          Text(
            'System configuration and device settings.',
            style: theme.text.body,
          ),
        ],
      ),
    )) ;
  }
}
