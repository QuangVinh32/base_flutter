import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class BluetoothPage extends StatelessWidget {
  const BluetoothPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return SizedBox.expand(child :Container(
      key: const ValueKey('bluetooth_page'),
      padding: const EdgeInsets.all(24),
      color: theme.colors.bgPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bluetooth & devices', style: theme.text.h1),
          const SizedBox(height: 16),
          Text(
            'Manage Bluetooth devices and connected hardware.',
            style: theme.text.body,
          ),
        ],
      ),
    )); 
  }
}
