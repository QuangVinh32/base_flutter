import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return SizedBox.expand(
      child: Container(
        key: const ValueKey('accounts_page'),
        padding: const EdgeInsets.all(24),
        color: theme.colors.bgPrimary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Accounts', style: theme.text.h1),
            const SizedBox(height: 16),
            Text(
              'User accounts, sign-in options and profiles.',
              style: theme.text.body,
            ),
          ],
        ),
      ),
    );
  }
}
