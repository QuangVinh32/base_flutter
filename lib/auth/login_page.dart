import 'package:flutter/material.dart';
import 'package:shop_food_app/auth/auth_api.dart';
import 'package:shop_food_app/component/custom_input_field.dart';
import 'package:shop_food_app/component/show_snack_bar.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/pages/user_info.dart';
import 'package:shop_food_app/pages_app/user_profile_page.dart';
import 'package:shop_food_app/theme/app_colors.dart';
import 'package:shop_food_app/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage1 extends StatefulWidget {
  const LoginPage1({super.key});

  @override
  State<LoginPage1> createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _docNoController = TextEditingController();

  

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isRegister = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberLogin();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _docNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppTheme.of(context).colors;

    return Scaffold(
      backgroundColor: colors.bgPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.bgSecondary,
        title: Text(
          _isRegister ? 'Đăng ký' : 'Đăng nhập',
          style: TextStyle(color: colors.textPrimary),
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 380),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppUtils.radius),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(colors),
                const SizedBox(height: 20),
                _buildFormContent(colors),
                const SizedBox(height: 20),
                _buildAuthSwitch(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(AppColors colors) => Column(
    children: [
      Text(
        _isRegister ? 'Đăng ký' : 'Đăng nhập',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        _isRegister
            ? "Tạo tài khoản để sử dụng\nhồ sơ bệnh án điện tử"
            : "Vui lòng đăng nhập để tiếp tục\nvào hồ sơ bệnh án điện tử",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: colors.textSecondary),
      ),
    ],
  );

  // ================= FORM =================
  Widget _buildFormContent(AppColors colors) => Column(
    children: [
      AnimatedCrossFade(
        duration: const Duration(milliseconds: 250),
        crossFadeState: _isRegister
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: _buildLoginForm(colors),
        secondChild: _buildRegisterForm(colors),
      ),
      const SizedBox(height: 16),
      _buildAuthButton(colors),
      if (!_isRegister) const SizedBox(height: 20),
      if (!_isRegister) _buildSocialLoginSection(colors),
    ],
  );

  Widget _buildLoginForm(AppColors colors) => Column(
    children: [
      _buildPhoneField(colors),
      const SizedBox(height: 16),
      _buildPasswordField(
        colors: colors,
        controller: _passwordController,
        isVisible: _isPasswordVisible,
        onToggleVisibility: () =>
            setState(() => _isPasswordVisible = !_isPasswordVisible),
        hintText: 'Mật khẩu',
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                activeColor: colors.accent,
                onChanged: (v) => setState(() => _rememberMe = v ?? false),
              ),
              Text(
                'Ghi nhớ đăng nhập',
                style: TextStyle(fontSize: 13, color: colors.textSecondary),
              ),
            ],
          ),
          TextButton(
            onPressed: _forgotPassword,
            child: Text(
              'Quên mật khẩu?',
              style: TextStyle(color: colors.accent),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _buildRegisterForm(AppColors colors) => Column(
    children: [
      _buildPhoneField(colors),
      const SizedBox(height: 16),
      _buildDocNoField(colors),
      const SizedBox(height: 16),
      _buildPasswordField(
        colors: colors,
        controller: _passwordController,
        isVisible: _isPasswordVisible,
        onToggleVisibility: () =>
            setState(() => _isPasswordVisible = !_isPasswordVisible),
      ),
      const SizedBox(height: 16),
      _buildPasswordField(
        colors: colors,
        controller: _confirmPasswordController,
        isVisible: _isConfirmPasswordVisible,
        onToggleVisibility: () => setState(
          () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
        ),
        hintText: 'Xác nhận mật khẩu',
        prefixIcon: Icons.verified,
      ),
    ],
  );

  // ================= INPUT =================
  Widget _buildPhoneField(AppColors colors) => CustomInputField(
    controller: _phoneController,
    hintText: "Số điện thoại hoặc CCCD",
    prefixIcon: Icons.person,
    primaryColor: colors.accent,
    keyboardType: TextInputType.number,
  );

  Widget _buildDocNoField(AppColors colors) => CustomInputField(
    controller: _docNoController,
    hintText: "Mã số hồ sơ",
    prefixIcon: Icons.description,
    primaryColor: colors.accent,
    keyboardType: TextInputType.number,
  );

  Widget _buildPasswordField({
    required AppColors colors,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    String hintText = "Mật khẩu",
    IconData prefixIcon = Icons.lock,
  }) => CustomInputField(
    controller: controller,
    hintText: hintText,
    prefixIcon: prefixIcon,
    obscureText: !isVisible,
    primaryColor: colors.accent,
    suffix: IconButton(
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: colors.textSecondary,
      ),
      onPressed: onToggleVisibility,
    ),
  );

  // ================= BUTTON =================
  Widget _buildAuthButton(AppColors colors) => SizedBox(
    width: double.infinity,
    height: 48,
    child: ElevatedButton(
      onPressed: _isLoading ? null : (_isRegister ? _register : _login),
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.accent,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUtils.radius),
        ),
      ),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(
              _isRegister ? 'Đăng ký' : 'Đăng nhập',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
    ),
  );

  // ================= SOCIAL =================
  Widget _buildSocialLoginSection(AppColors colors) => Column(
    children: [
      const SizedBox(height: 12),
      _buildDividerWithText(colors, 'Hoặc đăng nhập với'),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: _buildSocialButton(
              colors,
              Icons.g_mobiledata_outlined,
              Colors.red,
              _loginWithGoogle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSocialButton(
              colors,
              Icons.facebook,
              Colors.blue,
              _loginWithFacebook,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSocialButton(
              colors,
              Icons.apple,
              colors.textPrimary,
              _loginWithApple,
            ),
          ),
        ],
      ),
    ],
  );

  Widget _buildSocialButton(
    AppColors colors,
    IconData icon,
    Color iconColor,
    VoidCallback onPressed,
  ) => OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      backgroundColor: colors.surface,
      side: BorderSide(color: colors.border),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppUtils.radius),
      ),
      minimumSize: const Size(0, 48),
    ),
    child: Icon(icon, size: 26, color: iconColor),
  );

  Widget _buildDividerWithText(AppColors colors, String text) => Row(
    children: [
      Expanded(child: Divider(color: colors.border)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          text,
          style: TextStyle(fontSize: 13, color: colors.textSecondary),
        ),
      ),
      Expanded(child: Divider(color: colors.border)),
    ],
  );

  // ================= SWITCH =================
  Widget _buildAuthSwitch(AppColors colors) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        _isRegister ? "Bạn đã có tài khoản?" : "Bạn chưa có tài khoản?",
        style: TextStyle(color: colors.textSecondary),
      ),
      TextButton(
        onPressed: _switchAuthMode,
        child: Text(
          _isRegister ? "Đăng nhập" : "Đăng ký",
          style: TextStyle(color: colors.accent),
        ),
      ),
    ],
  );

  // ================= LOGIC =================
  void _switchAuthMode() {
    setState(() {
      _isRegister = !_isRegister;
      _phoneController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _docNoController.clear();
      _rememberMe = false;
    });
  }

  Future<void> _loadRememberLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final rememberMe = prefs.getBool('remember_me') ?? false;

    if (rememberMe) {
      setState(() {
        _rememberMe = true;
        _phoneController.text = prefs.getString('username') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      });
    }
  }

  void _login() async {
    if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
      showErrorSnackBar(context, msg: "Vui lòng nhập đầy đủ thông tin");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final data = await AuthApi.login(
        username: _phoneController.text.trim(),
        password: _passwordController.text,
      );

      // LƯU NẾU CÓ GHI NHỚ
      final prefs = await SharedPreferences.getInstance();

      if (_rememberMe) {
        await prefs.setBool('remember_me', true);
        await prefs.setString('username', _phoneController.text.trim());
        await prefs.setString('password', _passwordController.text);
        await prefs.setString('token', data['token']);
      } else {
        await prefs.clear();
      }

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => UserInfoPage (user: data,)),
      );
    } catch (e) {
      showErrorSnackBar(
        context,
        msg: e.toString().replaceAll('Exception: ', ''),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showErrorSnackBar(context, msg: "Mật khẩu không khớp");
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _forgotPassword() {}
  void _loginWithGoogle() {}
  void _loginWithFacebook() {}
  void _loginWithApple() {}
}
