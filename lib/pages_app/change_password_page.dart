import 'package:flutter/material.dart';
import 'package:shop_food_app/component/custom_input_field.dart';
import 'package:shop_food_app/theme/app_colors.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _oldCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppTheme.of(context).colors;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.bgSecondary,
        title: Text("Đổi mật khẩu", style: TextStyle(color: colors.textPrimary)),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomInputField(
              controller: _oldCtrl,
              hintText: 'Mật khẩu hiện tại',
              obscureText: true,
              primaryColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              controller: _newCtrl,
              hintText: 'Mật khẩu mới',
              obscureText: true,
              primaryColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              controller: _confirmCtrl,
              hintText: 'Xác nhận mật khẩu mới',
              obscureText: true,
              primaryColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('Cập nhật mật khẩu'),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() {
    if (_newCtrl.text != _confirmCtrl.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Mật khẩu không khớp')));
      return;
    }
    // TODO: call API change password
    Navigator.pop(context);
  }
}
