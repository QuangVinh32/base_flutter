import 'package:flutter/material.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class SidebarItem extends StatelessWidget {
  final AppTheme theme;
  final IconData icon;
  final String text;
  final bool active;
  final bool hover;
  final double height;
  final VoidCallback onTap;
  final VoidCallback onEnter;
  final VoidCallback onExit;

  const SidebarItem({
    super.key,
    required this.theme,
    required this.icon,
    required this.text,
    required this.active,
    required this.hover,
    required this.height,
    required this.onTap,
    required this.onEnter,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
final bgColor = active
    ? theme.colors.surface
    : hover
        ? theme.colors.surface.withValues(alpha: 0.6)
        : Colors.transparent;

    final iconColor = active ? theme.colors.accent : theme.colors.textSecondary;
    final textColor = active ? theme.colors.textPrimary : theme.colors.textSecondary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onEnter(),
      onExit: (_) => onExit(),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: height,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppUtils.radius),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: active ? theme.colors.accent : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppUtils.radius),
                    bottomLeft: Radius.circular(AppUtils.radius),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: theme.text.body.copyWith(color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
