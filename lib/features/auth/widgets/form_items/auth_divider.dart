import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_styles.dart';

/// Reusable divider widget with center text for authentication forms
class AuthDivider extends StatelessWidget {
  final String text;
  final Color? dividerColor;
  final Color? textColor;
  final double? horizontalPadding;
  final TextStyle? textStyle;

  const AuthDivider({
    super.key,
    required this.text,
    this.dividerColor,
    this.textColor,
    required this.horizontalPadding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor ?? Colors.grey.shade300,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding!),
          child: Text(
            text,
            style: textStyle ??
                AppTextStyles.bodyMedium.copyWith(
                  color: textColor ?? Colors.grey.shade500,
                ),
          ),
        ),
        Expanded(
          child: Divider(
            color: dividerColor ?? Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
