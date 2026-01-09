import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool obscureText;
  final double borderRadius;
  final Color primaryColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.primaryColor,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffix,
    this.obscureText = false,
    this.borderRadius = 4,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  String? _errorText;
  bool _autoValidate = false;

  void _validate(String? value) {
    if (widget.validator == null) return;
    setState(() {
      _errorText = widget.validator!(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasError = _errorText != null;
    final iconColor = hasError ? Colors.red.shade700 : widget.primaryColor;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          onChanged: (value) {
            if (!_autoValidate) {
              setState(() => _autoValidate = true);
            }
            _validate(value);
            widget.onChanged?.call(value);
          },
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: iconColor)
                : null,
            suffixIcon: widget.suffix != null
                ? IconTheme(
                    data: IconThemeData(color: iconColor),
                    child: widget.suffix!,
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: hasError ? Colors.red.shade700 : Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: hasError ? Colors.red.shade700 : widget.primaryColor,
                width: 1.5,
              ),
            ),
            errorText: null,
          ),
        ),
        if (hasError)
          Positioned(
            left: 12,
            bottom: -15,
            child: Text(
              _errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 11,
                height: 1.2,
              ),
            ),
          ),
      ],
    );
  }
}
