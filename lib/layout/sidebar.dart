import 'package:flutter/material.dart';
import 'package:shop_food_app/layout/sidebar_item.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int>? onSelect;

  const Sidebar({
    super.key,
    this.selectedIndex = 0,
    this.onSelect,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int? _hoverIndex;
  int _selectedIndex = 0; // thêm biến quản lý selected

  static const double _itemHeight = 44;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // khởi tạo từ widget
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final List<Map<String, dynamic>> items = [
      {"text": "Home", "icon": Icons.home},
      {"text": "System", "icon": Icons.computer},
      {"text": "Bluetooth & devices", "icon": Icons.bluetooth},
      {"text": "Network & internet", "icon": Icons.wifi},
      {"text": "Apps", "icon": Icons.apps},
      {"text": "Accounts", "icon": Icons.person},
      {"text": "Time & language", "icon": Icons.language},
      {"text": "Privacy & security", "icon": Icons.security},
    ];

    return Container(
      width: 240,
      padding: const EdgeInsets.all(12),
      color: theme.colors.bgSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text("Local Account", style: theme.text.h2),
          const SizedBox(height: 24),
          for (int i = 0; i < items.length; i++)
            SidebarItem(
              theme: theme,
              icon: items[i]["icon"],
              text: items[i]["text"],
              height: _itemHeight,
              active: _selectedIndex == i, // dùng state bên trong
              hover: _hoverIndex == i,
              onEnter: () => setState(() => _hoverIndex = i),
              onExit: () => setState(() => _hoverIndex = null),
              onTap: () {
                setState(() => _selectedIndex = i); // cập nhật màu
                widget.onSelect?.call(i); // gọi callback ra ngoài nếu có
              },
            ),
        ],
      ),
    );
  }
}

