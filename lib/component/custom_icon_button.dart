import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        hoverColor: theme.colors.surface.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: theme.colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
