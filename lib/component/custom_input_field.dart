import 'package:flutter/material.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_colors.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;

  final IconData? prefixIcon;
  final Widget? suffix;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;

  final double borderRadius;
  final TextInputType keyboardType;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  final Color primaryColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? iconColor;
  final Color? disabledColor;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.primaryColor,

    this.labelText,
    this.prefixIcon,
    this.suffix,

    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,

    this.borderRadius = AppUtils.radius,
    this.keyboardType = TextInputType.text,

    this.validator,
    this.onChanged,

    this.borderColor,
    this.focusedBorderColor,
    this.errorColor,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.iconColor,
    this.disabledColor,
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
        final AppColors colors = AppTheme.of(context).colors;

    final bool hasError = _errorText != null;

    final Color errorColor =
        widget.errorColor ?? Colors.red.shade600;

    final Color borderColor =
        widget.borderColor ?? Colors.grey.shade400;

    final Color focusColor =
        widget.focusedBorderColor ?? widget.primaryColor;

    final Color iconColor = !widget.enabled
        ? (widget.disabledColor ?? Colors.grey)
        : hasError
            ? errorColor
            : (widget.iconColor ?? widget.primaryColor);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          style: TextStyle(
            color: widget.enabled
                ? (widget.textColor ?? colors.textPrimary)
                : (widget.disabledColor ?? Colors.grey),
            fontSize: 14,
          ),
          onChanged: (value) {
            if (!_autoValidate) {
              setState(() => _autoValidate = true);
            }
            _validate(value);
            widget.onChanged?.call(value);
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: widget.hintColor ?? Colors.grey,
              fontSize: 14,
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: widget.labelColor ?? widget.primaryColor,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: iconColor)
                : null,
            suffixIcon: widget.suffix != null
                ? IconTheme(
                    data: IconThemeData(color: iconColor),
                    child: widget.suffix!,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: hasError ? errorColor : borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: hasError ? errorColor : focusColor,
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.disabledColor ?? Colors.grey.shade300,
              ),
            ),
            errorText: null,
          ),
        ),

        if (hasError)
          Positioned(
            left: 12,
            bottom: -16,
            child: Text(
              _errorText!,
              style: TextStyle(
                color: errorColor,
                fontSize: 11,
                height: 1.2,
              ),
            ),
          ),
      ],
    );
  }
}
