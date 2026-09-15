import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_styles.dart';

/// Reusable header widget for authentication screens
/// Displays a title and subtitle with optional styling
class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double titleSubtitleSpacing;

  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    required this.titleSubtitleSpacing ,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle ??
                AppTextStyles.headingLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        SizedBox(height: AppSpacing.xs.h),
        if (subtitle != null)
          Center(
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: subtitleStyle ??
                  AppTextStyles.headingLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        if (subtitle != null) SizedBox(height: titleSubtitleSpacing),
      ],
    );
  }
}
