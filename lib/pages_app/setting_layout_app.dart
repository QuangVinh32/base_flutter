import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_list_page.dart';
import 'package:shop_food_app/auth/login_page.dart';
import 'package:shop_food_app/pages_app/vneid_app_bar.dart';
import 'package:shop_food_app/pages_app/vneid_bottom_bar.dart';

class SettingLayoutApp extends StatefulWidget {
  const SettingLayoutApp({super.key});

  @override
  State<SettingLayoutApp> createState() => _SettingLayoutAppState();
}

class _SettingLayoutAppState extends State<SettingLayoutApp> {
  int _index = 0;

  final List<String> _titles = const [
    'Trang chủ',
    'Dịch vụ',
    'Quét QR',
    'Thông báo',
    'Cá nhân',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: VNeIDAppBar(
      //   title: _titles[_index],
      //   onQr: () {
      //     setState(() => _index = 2);
      //   },
      //   onNotification: () {
      //     setState(() => _index = 3);
      //   },
      // ),
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
        return const ProductListPage();
      case 2:
        return const Center(child: Text('Quét QR'));
      case 3:
        return const Center(child: Text('Thông báo'));
      case 4:
        return const LoginPage1();
      default:
        return const SizedBox();
    }
  }
}
