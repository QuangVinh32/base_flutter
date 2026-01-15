import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_list_page.dart';
import 'package:shop_food_app/auth/login_page.dart';
import 'package:shop_food_app/pages_app/vneid_app_bar.dart';
import 'package:shop_food_app/pages_app/vneid_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        return const ProductListPage();
      case 1:
        return const Center(child: Text('Don hang'));
      case 3:
        return const Center(child: Text('Thông báo'));
      case 4:
        return const LoginPage1();
      default:
        return const SizedBox();
    }
  }
}

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  return token != null && token.isNotEmpty;
}
