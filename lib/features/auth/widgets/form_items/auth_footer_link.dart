import 'package:flutter/material.dart';
import 'package:internship_task/core/theme/app_styles.dart';

/// Reusable footer link widget for authentication forms
/// Used for navigation between login and register screens
class AuthFooterLink extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? style;
  final bool centered;

  const AuthFooterLink({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.centered = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: centered ? TextAlign.center : TextAlign.start,
        style: style ??
            AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );

    return centered ? Center(child: button) : button;
  }
}
