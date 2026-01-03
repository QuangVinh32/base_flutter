import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final items = [
      "Installed apps",
      "Advanced app settings",
      "Default apps",
      "Actions",
      "Offline maps",
      "Apps for websites",
      "Video playback",
      "Startup",
      "Resume",
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(

          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colors.surface, 
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colors.border, 
            ),
          ),
          child: Row(
            children: [
              Text(
                items[index],
                style: theme.text.body, 
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                color: theme.colors.textSecondary, 
              ),
            ],
          ),
        );
      },
    );
  }
}
