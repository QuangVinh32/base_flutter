import 'package:flutter/material.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final AppTheme theme;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? fontSize;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final int minLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onSuffixTap;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.theme,
    this.borderRadius,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSuffixTap,
    this.errorText,
    this.borderColor,
    this.focusedBorderColor,
    this.fontSize,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;
  bool _showSuffix = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _showSuffix = _controller.text.isNotEmpty;

    _controller.addListener(() {
      final hasText = _controller.text.isNotEmpty;
      if (hasText != _showSuffix) setState(() => _showSuffix = hasText);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    // final radius = widget.borderRadius ?? 8;

    return TextField(
      controller: _controller,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      cursorColor: theme.colors.textPrimary,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      style: theme.text.body.copyWith(
        // Text size nhập
        fontSize: widget.fontSize,
        color: widget.enabled
            ? theme.colors.textPrimary
            : theme.colors.textSecondary,
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: theme.text.caption.copyWith(fontSize: widget.fontSize),
        labelText: widget.labelText,
        labelStyle: theme.text.body.copyWith(color: theme.colors.textSecondary),
        errorText: widget.errorText,
        filled: true,
        fillColor: theme.colors.surface,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: theme.colors.textSecondary)
            : null,
        suffixIcon: (_showSuffix && widget.suffixIcon != null)
            ? GestureDetector(
                onTap: () {
                  _controller.clear();

                  // QUAN TRỌNG: trigger lại onChanged
                  widget.onChanged?.call('');
                  widget.onSuffixTap?.call();
                },
                child: Icon(
                  widget.suffixIcon,
                  color: theme.colors.textSecondary,
                ),
              )
            : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppUtils.radius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppUtils.radius),
          borderSide: BorderSide(color: theme.colors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppUtils.radius),
          borderSide: BorderSide(color: theme.colors.accent, width: 1.5),
        ),

        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
    );
  }
}
