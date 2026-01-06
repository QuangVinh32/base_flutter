import 'package:flutter/material.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class UserInfo extends StatelessWidget {
  final AppTheme theme;

  const UserInfo({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(AppUtils.radius),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              "https://jbagy.me/wp-content/uploads/2025/04/Hinh-meme-meo-cuoi-deu-2.jpg",
              width: 36,
              height: 36,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.person, color: theme.colors.textPrimary),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lê Quang Vinh",
                  style: theme.text.body.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "trcuong666@gmail.com",
                  style: theme.text.caption,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
