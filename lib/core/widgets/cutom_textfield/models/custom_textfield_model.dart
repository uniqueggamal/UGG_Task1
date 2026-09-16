import 'package:flutter/material.dart';

enum FieldState { normal, warning, error }

class CustomTextFieldModel {
  final FieldState state;
  final String? message;

  final TextEditingController controller;

  final String? hintText;
  final String? labelText;

  final IconData? prefixIcon;
  final Widget? suffixIcon;

  final bool obscureText;
  final bool enabled;
  final bool readOnly;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  final int maxLines;
  final int? maxLength;

  final InputDecoration? inputDecoration;

  const CustomTextFieldModel({
    this.state = FieldState.normal,

    this.message,

    required this.controller,

    this.hintText,
    this.labelText,

    this.prefixIcon,
    this.suffixIcon,

    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,

    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.maxLength,
    this.inputDecoration,
  });
}
