import 'package:flutter/material.dart';
import 'package:shop_food_app/component/custom_input_field.dart';
import 'package:shop_food_app/component/show_snack_bar.dart';


class LoginPage1 extends StatefulWidget {
  @override
  _LoginPage1State createState() => _LoginPage1State();
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

  final Color _primaryColor = Colors.green.shade700;

  final _buttonBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(_isRegister ? 'Đăng ký' : 'Đăng nhập')),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 380),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const SizedBox(height: 15),
                _buildFormContent(),
                const SizedBox(height: 15),
                _buildAuthSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Column(
        children: [
          Text(
            _isRegister ? 'Đăng ký' : 'Đăng nhập',
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 5),
          Text(
            _isRegister
                ? "Tạo tài khoản để sử dụng app\nhồ sơ bệnh án điện tử"
                : "Vui lòng đăng nhập để tiếp tục\nvào app hồ sơ bệnh án điện tử",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      );

  Widget _buildFormContent() => Column(
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isRegister
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: _buildLoginForm(),
            secondChild: _buildRegisterForm(),
          ),
          const SizedBox(height: 10),
          if (_isRegister) const SizedBox(height: 7),
          _buildAuthButton(),
          if (!_isRegister) const SizedBox(height: 16),
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (v) => setState(() => _rememberMe = v ?? false),
                    activeColor: _primaryColor,
                  ),
                  Text('Ghi nhớ đăng nhập',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                ],
              ),
              TextButton(
                onPressed: _forgotPassword,
                child: Text('Quên mật khẩu?',
                    style: TextStyle(color: _primaryColor, fontSize: 13)),
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
                () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
            hintText: 'Xác nhận mật khẩu',
            prefixIcon: Icons.verified,
          ),
        ],
      );

  Widget _buildPhoneField() => CustomInputField(
        controller: _phoneController,
        hintText: "Số điện thoại hoặc CCCD",
        prefixIcon: Icons.person,
        primaryColor: _primaryColor,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Vui lòng nhập số điện thoại";
          }
          if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "Chỉ được nhập số";
          if (value.length < 10) return "Số điện thoại phải có ít nhất 10 số";
          return null;
        },
      );

  Widget _buildDocNoField() => CustomInputField(
        controller: _docNoController,
        hintText: "Số mã số hồ sơ",
        prefixIcon: Icons.description,
        primaryColor: _primaryColor,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Vui lòng nhập mã số hồ sơ";
          }
          if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "Chỉ được nhập số";
          return null;
        },
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
        primaryColor: _primaryColor,
        borderRadius: 4,
        validator: (value) {
          if (value == null || value.isEmpty) return "Vui lòng nhập mật khẩu";
          // if (value.length < 6) return "Mật khẩu phải có ít nhất 6 ký tự";
          return null;
        },
        suffix: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey),
          onPressed: onToggleVisibility,
        ),
      );

  Widget _buildAuthButton() => SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _isLoading ? null : (_isRegister ? _register : _login),
          style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.green.shade700)
              : Text(_isRegister ? 'Đăng ký' : 'Đăng nhập',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );

Widget _buildSocialLoginSection() => Column(
      children: [
        const SizedBox(height: 10),
        _buildDividerWithText('Hoặc đăng nhập với'),
        const SizedBox(height: 20),
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
                Colors.blue.shade800,
                _loginWithFacebook,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSocialButton(
                Icons.apple,
                Colors.black,
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
) {
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Colors.grey.shade300),
      shape: _buttonBorder,
      backgroundColor: Colors.white,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 50), // giữ chiều cao
    ),
    child: Icon(icon, size: 30, color: color),
  );
}


  Widget _buildDividerWithText(String text) => Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(text,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
          ),
          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        ],
      );

  Widget _buildAuthSwitch() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_isRegister ? "Bạn đã có tài khoản?" : "Bạn chưa có tài khoản?"),
          TextButton(
            onPressed: _switchAuthMode,
            child: Text(_isRegister ? "Đăng nhập" : "Đăng ký",
                style: TextStyle(color: _primaryColor)),
          ),
        ],
      );

  void _switchAuthMode() {
    setState(() {
      _isRegister = !_isRegister;
      _phoneController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _rememberMe = false;
      if (!_isRegister) _loadSavedCredentials();
    });
  }

  void _login() async {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    setState(() => _isLoading = true);
    // final appModel = AppStateModel.of(context);
    // if (phone.isEmpty || password.isEmpty) {
    //   showErrorSnackBar(context, msg: "Vui lòng điền đầy đủ thông tin!");
    //   setState(() => _isLoading = false);
    //   return;
    // }

    // final user = await appModel.login(context, phone, password, "/home");
    // final prefs = await SharedPreferences.getInstance();

    // if (_rememberMe) {
    //   await prefs.setString('saved_phone', phone);
    //   await prefs.setString('saved_password', password);
    //   await prefs.setBool('remember_me', true);
    // } else {
    //   await prefs.remove('saved_phone');
    //   await prefs.remove('saved_password');
    //   await prefs.setBool('remember_me', false);
    // }

    // if (user == null || user.userId == "invalid_user") {
    //   showErrorSnackBar(context, msg: "Sai số điện thoại hoặc mật khẩu!");
    // }

    setState(() => _isLoading = false);
  }

  void _register() async {
    final phone = _phoneController.text.trim();
    final docNoText = _docNoController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    if (phone.isEmpty ||
        docNoText.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {
      showErrorSnackBar(context, msg: "Vui lòng điền đầy đủ thông tin!");
      return;
    }
    if (password != confirm) {
      showErrorSnackBar(context,
          msg: "Mật khẩu và xác nhận mật khẩu không khớp!");
      return;
    }

    final docNo = int.tryParse(docNoText);
    if (docNo == null) {
      showErrorSnackBar(context, msg: "Mã số hồ sơ phải là số hợp lệ!");
      return;
    }

    setState(() => _isLoading = true);

    // final appModel = AppStateModel.of(context);
    // final success = await appModel.signup(context, phone, docNo, password);
    setState(() => _isLoading = false);
  }

  void _forgotPassword() {}
  void _loginWithGoogle() {}
  void _loginWithFacebook() {}
  void _loginWithApple() {}

  _loadSavedCredentials() async {
    // final prefs = await SharedPreferences.getInstance();
    setState(() {
      // _phoneController.text = prefs.getString('saved_phone') ?? '';
      // _passwordController.text = prefs.getString('saved_password') ?? '';
      // _rememberMe = prefs.getBool('remember_me') ?? false;
    });
  }
}
