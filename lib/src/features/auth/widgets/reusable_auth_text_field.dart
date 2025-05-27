
import 'dart:async';
import 'package:flutter/material.dart';
import '../../../res/colors.dart';

enum ValidationTrigger {
  onChange, // Validate on every text change
  onBlur,   // Validate when the field loses focus
  manual,   // Validate manually (e.g., when a button is pressed)
}

class ReusableAuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? defaultBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final TextStyle? errorTextStyle;
  final ValidationTrigger validationTrigger;

  const ReusableAuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.defaultBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.errorTextStyle,
    this.validationTrigger = ValidationTrigger.onBlur, // Default to onBlur
  });

  @override
  _ReusableAuthTextFieldState createState() => _ReusableAuthTextFieldState();
}

class _ReusableAuthTextFieldState extends State<ReusableAuthTextField> {
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(true);
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validate);
    _focusNode.addListener(_onFocusChange); // Listen to focus changes
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Validate only when the field loses focus
      _validate();
    }
  }

  void _validate() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final isValid = widget.validator?.call(widget.controller.text) == null;
      _isValid.value = isValid;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validate);
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _isValid.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isValid,
      builder: (context, isValid, child) {
        return TextFormField(
          controller: widget.controller,
          onChanged: (value) {
            widget.onChanged?.call(value);
            if (widget.validationTrigger == ValidationTrigger.onChange) {
              _validate();
            }
          },
          onFieldSubmitted: (value) {
            if (widget.validationTrigger == ValidationTrigger.onBlur) {
              _validate();
            }
          },
          obscureText: widget.obscureText ?? false,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: AppColors.grey),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: widget.defaultBorderColor ?? AppColors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                // Show default or focused border while the field is focused
                color: _focusNode.hasFocus
                    ? widget.focusedBorderColor ?? AppColors.theme
                    : isValid
                    ? widget.defaultBorderColor ?? AppColors.grey
                    : widget.errorBorderColor ?? AppColors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: widget.focusedBorderColor ?? AppColors.theme,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: widget.errorBorderColor ?? AppColors.red,
                width: 1,
              ),
            ),
            errorText: isValid || _focusNode.hasFocus
                ? null
                : widget.validator?.call(widget.controller.text),
            errorStyle: widget.errorTextStyle ??  TextStyle(color: AppColors.red),
          ),
          validator: widget.validator,
        );
      },
    );
  }
}
