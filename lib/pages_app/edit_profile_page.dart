import 'package:flutter/material.dart';
import 'package:shop_food_app/component/custom_input_field.dart';
import 'package:shop_food_app/theme/app_colors.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user['fullName']);
    _phoneCtrl = TextEditingController(text: widget.user['phone']);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppTheme.of(context).colors;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.bgSecondary,
        title: Text(
          "Cập nhật thông tin cá nhân",
          style: TextStyle(color: colors.textPrimary),
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomInputField(
              controller: _nameCtrl,
              hintText: 'Họ tên',
              primaryColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              controller: _phoneCtrl,
              hintText: 'Số điện thoại',
              keyboardType: TextInputType.phone,
              primaryColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _save, child: const Text('Lưu thay đổi')),
          ],
        ),
      ),
    );
  }

  void _save() {
    // TODO: call API update profile
    Navigator.pop(context);
  }
}
