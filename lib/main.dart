import 'package:flutter/material.dart';
import 'package:shop_food_app/layout/content.dart';
import 'package:shop_food_app/layout/header.dart';
import 'package:shop_food_app/layout/Sidebar.dart';
import 'package:shop_food_app/pages/accounts_page.dart';
import 'package:shop_food_app/pages/apps_page.dart';
import 'package:shop_food_app/pages/bluetooth_page.dart';
import 'package:shop_food_app/pages/home_page.dart';
import 'package:shop_food_app/pages/language_page.dart';
import 'package:shop_food_app/pages/network_page.dart';
import 'package:shop_food_app/pages/privacy_page.dart';
import 'package:shop_food_app/pages/system_page.dart';
import 'package:shop_food_app/theme/app_colors.dart';
import 'package:shop_food_app/theme/app_theme.dart';

void main() {
  runApp(AppTheme(colors: AppColors.light, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const SettingsLayout(),
    );
  }
}

class SettingsLayout extends StatefulWidget {
  const SettingsLayout({super.key});

  @override
  State<SettingsLayout> createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<SettingsLayout> {
  bool isSidebarOpen = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1024;
        return Scaffold(
          backgroundColor: theme.colors.bgSecondary,
          body: Stack(
            children: [
              Row(
                children: [
                  if (isDesktop) ...[
                    Sidebar(
                      selectedIndex: selectedIndex,
                      onSelect: (index) {
                        setState(() {
                          selectedIndex = index;
                          isSidebarOpen = false;
                        });
                      },
                    ),
                    Container(width: 1, color: theme.colors.border),
                  ],
                  Expanded(
                    child: Column(
                      children: [
                        Header(
                          showMenu: !isDesktop,
                          onMenuTap: () {
                            setState(() => isSidebarOpen = true);
                          },
                        ),
                        Expanded(child: _buildContent(selectedIndex)),
                      ],
                    ),
                  ),
                ],
              ),
              if (!isDesktop)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSidebarOpen ? 1 : 0,
                  child: IgnorePointer(
                    ignoring: !isSidebarOpen,
                    child: GestureDetector(
                      onTap: () => setState(() => isSidebarOpen = false),
                      child: Container(color: Colors.black45),
                    ),
                  ),
                ),

              if (!isDesktop)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  left: isSidebarOpen ? 0 : -260,
                  top: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: 260,
                    child: Material(
                      color: theme.colors.bgSecondary,
                      elevation: 16,
                      child: Sidebar(
                        selectedIndex: selectedIndex,
                        onSelect: (index) {
                          setState(() {
                            selectedIndex = index;
                            isSidebarOpen = false;
                          });
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildContent(int index) {
  switch (index) {
    case 0:
      return const HomePage();
    case 1:
      return const SystemPage();
    case 2:
      return const BluetoothPage();
    case 3:
      return const NetworkPage();
    case 4:
      return const AppsPage();
    case 5:
      return const AccountsPage();
    case 6:
      return const LanguagePage();
    case 7:
      return const PrivacyPage();
    default:
      return const HomePage();
  }
}
