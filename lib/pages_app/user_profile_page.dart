import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';
import 'package:shop_food_app/library/app_utils.dart';

class UserInfoPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const UserInfoPage({
    super.key,
    required this.user,
  });

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool _notifyEnabled = true;

  String _s(dynamic v, [String fallback = '--']) {
    if (v == null) return fallback;
    if (v is String && v.trim().isNotEmpty) return v;
    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colors = theme.colors;

    return Scaffold(
      backgroundColor: colors.bgPrimary,
      appBar: AppBar(
        title: const Text('Tài khoản'),
        backgroundColor: colors.bgSecondary,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(theme),
          const SizedBox(height: 24),

          _section(
            theme,
            title: 'Thông tin cá nhân',
            children: [
              _infoRow('Họ tên', _s(widget.user['fullName'])),
              _infoRow('Địa chỉ', _s(widget.user['address'])),
              _infoRow('Email', _s(widget.user['email'])),
              _infoRow('Số điện thoại', _s(widget.user['phone'])),
              // _infoRow('Vai trò', _s(widget.user['role'])),
            ],
          ),

          const SizedBox(height: 24),

          _section(
            theme,
            title: 'Cài đặt',
            children: [
              _actionTile(
                icon: Icons.edit,
                text: 'Cập nhật thông tin',
                onTap: () {
                  // TODO: Navigate update profile
                },
              ),
              _actionTile(
                icon: Icons.lock_outline,
                text: 'Đổi mật khẩu',
                onTap: () {
                  // TODO: Navigate change password
                },
              ),
              _switchTile(
                icon: Icons.notifications_outlined,
                text: 'Thông báo',
                value: _notifyEnabled,
                onChanged: (v) {
                  setState(() => _notifyEnabled = v);
                },
              ),
              _actionTile(
                icon: Icons.settings_outlined,
                text: 'Cài đặt chung',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 16),

          _section(
            theme,
            children: [
              _actionTile(
                icon: Icons.logout,
                text: 'Đăng xuất',
                color: colors.error,
                onTap: () {
                  _confirmLogout(context, theme);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== HEADER =====
  Widget _buildHeader(AppTheme theme) {
    final colors = theme.colors;
    final avatar = widget.user['image'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppUtils.radius),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage:
                avatar != null ? NetworkImage(avatar) : null,
            child: avatar == null
                ? Icon(Icons.person, size: 36, color: colors.textSecondary)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _s(widget.user['fullName'], 'Chưa cập nhật'),
                  style: theme.text.h2.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _s(widget.user['email']),
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

  // ===== SECTION =====
  Widget _section(
    AppTheme theme, {
    String? title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(AppUtils.radius),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                title,
                style: theme.text.caption.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(height: 1),
          ],
          ...children,
        ],
      ),
    );
  }

  // ===== INFO ROW =====
  Widget _infoRow(String label, String value) {
    return ListTile(
      dense: true,
      title: Text(label),
      trailing: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  // ===== ACTION TILE =====
  Widget _actionTile({
    required IconData icon,
    required String text,
    Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: color != null
            ? TextStyle(color: color, fontWeight: FontWeight.w600)
            : null,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  // ===== SWITCH TILE =====
  Widget _switchTile({
    required IconData icon,
    required String text,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon),
      title: Text(text),
    );
  }

  // ===== LOGOUT CONFIRM =====
  void _confirmLogout(BuildContext context, AppTheme theme) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: clear token + navigate login
            },
            child: Text(
              'Đăng xuất',
              style: TextStyle(color: theme.colors.error),
            ),
          ),
        ],
      ),
    );
  }
}
