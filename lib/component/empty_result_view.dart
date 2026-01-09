import 'package:flutter/material.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class EmptyResultView extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? description;
  final double iconSize;

  const EmptyResultView({
    super.key,
    this.icon,
    this.title,
    this.description,
    this.iconSize = 72,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ICON
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colors.surface,
              ),
              child: Icon(
                icon ?? Icons.search_off_rounded,
                size: iconSize,
                color: theme.colors.textDisabled,
              ),
            ),

            const SizedBox(height: 20),

            // TITLE
            Text(
              title ?? 'Không tìm thấy kết quả',
              style: theme.text.body.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // DESCRIPTION
            Text(
              description ??
                  '',
              style: theme.text.body.copyWith(
                color: theme.colors.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
