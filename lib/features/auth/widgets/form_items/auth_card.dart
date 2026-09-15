import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_styles.dart';
import 'auth_header.dart';
import 'auth_error_message.dart';
import 'auth_button.dart';
import 'auth_divider.dart';
import 'auth_footer_link.dart';

/// Generic authentication card widget that can be used for login or register forms
class AuthCard extends StatelessWidget {
  final List<Widget> headerFields;
  final List<Widget> formFields;
  final String? errorMessage;
  final String buttonText;
  final bool isLoading;
  final VoidCallback? onButtonPressed;
  final String dividerText;
  final String footerText;
  final VoidCallback? onFooterPressed;

  const AuthCard({
    super.key,
    required this.headerFields,
    required this.formFields,
    this.errorMessage,
    required this.buttonText,
    this.isLoading = false,
    this.onButtonPressed,
    this.dividerText = 'or',
    required this.footerText,
    this.onFooterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xxl.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 30,
            offset: Offset(0, 12),
            spreadRadius: 0,
            color: Color(0x22000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...headerFields,

          SizedBox(height: AppSpacing.xxl.h),

          // Form fields
          ...formFields,

          // Error message
          if (errorMessage != null) ...[
            SizedBox(height: AppSpacing.sm.h),
            AuthErrorMessage(message: errorMessage!),
          ],

          SizedBox(height: AppSpacing.xxl.h),

          // Button
          AuthButton(
            text: buttonText,
            isLoading: isLoading,
            onPressed: onButtonPressed,
            borderRadius: AppRadius.medium,
            height: AppSpacing.buttonHeight1.h,
          ),

          SizedBox(height: AppSpacing.xl.h),

          // Divider
          AuthDivider(text: dividerText, horizontalPadding: AppSpacing.lg.r),

          SizedBox(height: AppSpacing.md.h),

          // Footer link
          AuthFooterLink(text: footerText, onPressed: onFooterPressed),
        ],
      ),
    );
  }
}
