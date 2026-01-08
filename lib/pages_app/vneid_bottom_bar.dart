import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class VNeIDBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const VNeIDBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;

    return Container(
      height: 72,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.textSecondary, 
            colors.textPrimary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(context, 0, Icons.home_outlined, 'Trang chủ'),
          _item(context, 1, Icons.folder_outlined, 'Dịch vụ'),
          _centerItem(context),
          _item(context, 3, Icons.notifications_outlined, 'Thông báo'),
          _item(context, 4, Icons.person_outline, 'Cá nhân'),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final colors = AppTheme.of(context).colors;
    final bool active = index == currentIndex;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: active
                  ? colors.accent        // vàng kim (Tết)
                  : colors.bgSecondary,  // trắng / xám
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: active
                    ? colors.accent
                    : colors.bgSecondary,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerItem(BuildContext context) {
    final colors = AppTheme.of(context).colors;

    return GestureDetector(
      onTap: () => onTap(2),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              colors.accentHover, // vàng sáng
              colors.accent,      // vàng kim
            ],
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black38,
            ),
          ],
        ),
        child: Icon(
          Icons.qr_code_scanner,
          color: colors.textPrimary, // đỏ sẫm (Tết)
          size: 28,
        ),
      ),
    );
  }
}
