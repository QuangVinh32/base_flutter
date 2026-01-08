import 'package:flutter/material.dart';
import 'package:shop_food_app/pages_app/vneid_bottom_bar.dart';

class SettingLayoutApp extends StatefulWidget {
  const SettingLayoutApp({super.key});

  @override
  State<SettingLayoutApp> createState() => _SettingLayoutAppState();
}

class _SettingLayoutAppState extends State<SettingLayoutApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(),
      bottomNavigationBar: VNeIDBottomBar(
        currentIndex: _index,
        onTap: (i) {
          setState(() => _index = i);
        },
      ),
    );
  }

  Widget _buildPage() {
    switch (_index) {
      case 0:
        return const Center(child: Text('Trang chủ'));
      case 1:
        return const Center(child: Text('Dịch vụ'));
      case 2:
        return const Center(child: Text('Quét QR'));
      case 3:
        return const Center(child: Text('Thông báo'));
      case 4:
        return const Center(child: Text('Cá nhân'));
      default:
        return const SizedBox();
    }
  }
}
