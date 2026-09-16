import 'package:flutter/material.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';

/// Reusable error message widget for authentication forms
class AuthErrorMessage extends StatelessWidget {
  final String message;
  final TextStyle? style;
  final bool centered;

  const AuthErrorMessage({
    super.key,
    required this.message,
    this.style,
    this.centered = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = Text(
      message,
      style: style ??
          AppTextStyles.bodyMedium.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
    );

    return centered ? Center(child: child) : child;
  }
}
