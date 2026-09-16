import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/theme/app_radius.dart';

import 'models/custom_textfield_model.dart';

/// A reusable text field used throughout the application.
class CustomTextField extends StatelessWidget {
  final CustomTextFieldModel model;
  const CustomTextField({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: model.controller,

      obscureText: model.obscureText,
      enabled: model.enabled,
      readOnly: model.readOnly,

      keyboardType: model.keyboardType,
      textInputAction: model.textInputAction,

      validator: model.validator,
      onChanged: model.onChanged,
      onFieldSubmitted: model.onFieldSubmitted,

      maxLines: model.obscureText ? 1 : model.maxLines,
      maxLength: model.maxLength,

      style: AppTextStyles.bodyLarge,

      decoration: InputDecoration(
        hintText: model.hintText,
        labelText: model.labelText,

        prefixIcon: model.prefixIcon != null
            ? Icon(model.prefixIcon, color: _stateColor)
            : null,

        suffixIcon: model.suffixIcon,

        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.8),

        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg.w,
          vertical: AppSpacing.lg.h,
        ),

        border: _border(color: _stateColor),

        enabledBorder: _border(color: _stateColor),

        focusedBorder: _border(color: _stateColor, width: 1.5),

        errorBorder: _border(color: AppColors.error, width: 1.5),

        focusedErrorBorder: _border(color: AppColors.error, width: 2),

        errorText: model.message,
        errorStyle: TextStyle(color: _stateColor),
      ),
    );
  }

  Color get _stateColor {
    switch (model.state) {
      case FieldState.normal:
        return AppColors.primary;

      case FieldState.warning:
        return AppColors.warning;

      case FieldState.error:
        return AppColors.error;
    }
  }

  OutlineInputBorder _border({required Color color, double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
