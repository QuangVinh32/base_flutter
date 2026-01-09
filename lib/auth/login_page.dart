import 'package:flutter/material.dart';
import 'package:shop_food_app/component/custom_input_field.dart';
import 'package:shop_food_app/component/show_snack_bar.dart';
import 'package:shop_food_app/theme/app_colors.dart';
import 'package:shop_food_app/library/app_utils.dart';

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

  late final AppColors colors;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    colors = AppColors.light; // sau này đổi dark / tet rất dễ
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
                _buildHeader(),
                const SizedBox(height: 20),
                _buildFormContent(),
                const SizedBox(height: 20),
                _buildAuthSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() => Column(
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
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
            ),
          ),
        ],
      );

  // ================= FORM =================
  Widget _buildFormContent() => Column(
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _isRegister
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: _buildLoginForm(),
            secondChild: _buildRegisterForm(),
          ),
          const SizedBox(height: 16),
          _buildAuthButton(),
          if (!_isRegister) const SizedBox(height: 20),
          if (!_isRegister) _buildSocialLoginSection(),
        ],
      );

  Widget _buildLoginForm() => Column(
        children: [
          _buildPhoneField(),
          const SizedBox(height: 16),
          _buildPasswordField(
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
                    onChanged: (v) =>
                        setState(() => _rememberMe = v ?? false),
                  ),
                  Text(
                    'Ghi nhớ đăng nhập',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.textSecondary,
                    ),
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

  Widget _buildRegisterForm() => Column(
        children: [
          _buildPhoneField(),
          const SizedBox(height: 16),
          _buildDocNoField(),
          const SizedBox(height: 16),
          _buildPasswordField(
            controller: _passwordController,
            isVisible: _isPasswordVisible,
            onToggleVisibility: () =>
                setState(() => _isPasswordVisible = !_isPasswordVisible),
            hintText: 'Mật khẩu',
          ),
          const SizedBox(height: 16),
          _buildPasswordField(
            controller: _confirmPasswordController,
            isVisible: _isConfirmPasswordVisible,
            onToggleVisibility: () => setState(
                () => _isConfirmPasswordVisible =
                    !_isConfirmPasswordVisible),
            hintText: 'Xác nhận mật khẩu',
            prefixIcon: Icons.verified,
          ),
        ],
      );

  // ================= INPUT =================
  Widget _buildPhoneField() => CustomInputField(
        controller: _phoneController,
        hintText: "Số điện thoại hoặc CCCD",
        prefixIcon: Icons.person,
        primaryColor: colors.accent,
        keyboardType: TextInputType.number,
      );

  Widget _buildDocNoField() => CustomInputField(
        controller: _docNoController,
        hintText: "Mã số hồ sơ",
        prefixIcon: Icons.description,
        primaryColor: colors.accent,
        keyboardType: TextInputType.number,
      );

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    String hintText = "Mật khẩu",
    IconData prefixIcon = Icons.lock,
  }) =>
      CustomInputField(
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
  Widget _buildAuthButton() => SizedBox(
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      );

  // ================= SOCIAL =================
  Widget _buildSocialLoginSection() => Column(
        children: [
          const SizedBox(height: 12),
          _buildDividerWithText('Hoặc đăng nhập với'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSocialButton(
                  Icons.g_mobiledata_outlined,
                  Colors.red,
                  _loginWithGoogle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSocialButton(
                  Icons.facebook,
                  Colors.blue.shade700,
                  _loginWithFacebook,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSocialButton(
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
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) =>
      OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: colors.surface,
          side: BorderSide(color: colors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppUtils.radius),
          ),
          minimumSize: const Size(0, 48),
        ),
        child: Icon(icon, size: 26, color: color),
      );

  Widget _buildDividerWithText(String text) => Row(
        children: [
          Expanded(child: Divider(color: colors.border)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: colors.textSecondary,
              ),
            ),
          ),
          Expanded(child: Divider(color: colors.border)),
        ],
      );

  // ================= SWITCH =================
  Widget _buildAuthSwitch() => Row(
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

  void _login() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
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
