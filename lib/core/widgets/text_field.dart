import 'package:flutter/material.dart';
import 'package:internship_task/core/theme/app_styles.dart';

/// A custom text field used specifically for the login screen
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool isLoading;

  const CustomTextField({
    super.key,
    required this.controller,
    this.icon,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: !isLoading,
      controller: controller,
      obscureText: obscureText,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon, color: AppColors.primary) : null,
        suffixIcon: suffixIcon,

        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.8),

        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg.w,
          vertical: AppSpacing.lg.h,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.1),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.1),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),

        errorStyle: const TextStyle(color: AppColors.error),
      ),
    );
  }
}
