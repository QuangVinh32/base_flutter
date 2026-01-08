import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class VNeIDAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onQr;
  final VoidCallback? onNotification;
  final bool showBack;

  const VNeIDAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onQr,
    this.onNotification,
    this.showBack = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;

    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: colors.textSecondary, 
      title: Text(
        title,
        style: TextStyle(
          color: colors.bgSecondary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: showBack
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: colors.bgSecondary,
                size: 20,
              ),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : IconButton(
              icon: Icon(
                Icons.menu,
                color: colors.bgSecondary,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.qr_code_scanner,
            color: colors.bgSecondary,
          ),
          onPressed: onQr,
        ),
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: colors.bgSecondary,
          ),
          onPressed: onNotification,
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}
