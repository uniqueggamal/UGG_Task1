import 'package:flutter/material.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/core/theme/app_spacing.dart';

class IdentityCardHeader extends StatelessWidget {
  const IdentityCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSpacing.control.h,
      decoration: BoxDecoration(
        color: AppColors.highlightSurface.withOpacity(0.8),
      ),
      child: Center(
        child: Text(
          "Identity Card",
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.textMuted,
            letterSpacing: 5,
          ),
        ),
      ),
    );
  }
}
