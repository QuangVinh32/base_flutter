import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class AppsPage extends StatelessWidget {
  const AppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return SizedBox.expand(
      child: Container(
        key: const ValueKey('apps_page'),
        padding: const EdgeInsets.all(24),
        color: theme.colors.bgSecondary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apps', style: theme.text.h1),
            const SizedBox(height: 16),
            Text(
              'Installed applications, defaults and permissions.',
              style: theme.text.body,
            ),
          ],
        ),
      ),
    );
  }
}
