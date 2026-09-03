import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/shared/utils/app_styles.dart';
import 'login_logo.dart';
import 'text_field.dart';

/// The main login card widget that contains all login form elements
class LoginCard extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final bool hidePassword;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onTogglePassword;
  final VoidCallback onLogin;

  const LoginCard({
    super.key,
    required this.email,
    required this.password,
    required this.hidePassword,
    required this.isLoading,
    required this.errorMessage,
    required this.onTogglePassword,
    required this.onLogin,
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
          /// Logo
          const Center(child: LoginLogo()),

          SizedBox(height: AppSpacing.xl.h),

          /// Heading
          Center(
            child: Text(
              'Welcome to',
              textAlign: TextAlign.center,
              style: AppTextStyles.headingLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          SizedBox(height: AppSpacing.xs.h),

          Center(
            child: Text(
              'NCCS Internship',
              textAlign: TextAlign.center,
              style: AppTextStyles.headingLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          SizedBox(height: AppSpacing.sm.h),

          /// Subtitle
          Center(
            child: Text(
              'Please login to continue',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.grey.shade600,
                letterSpacing: 0.8,
              ),
            ),
          ),

          SizedBox(height: AppSpacing.xxl.h),

          /// Email
          Text(
            'Email',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: AppSpacing.sm.h),

          CustomTextField(
            controller: email,
            icon: Icons.person_outline,
            hintText: 'Enter email',
          ),

          SizedBox(height: AppSpacing.lg.h),

          /// Password
          Text(
            'Password',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: AppSpacing.sm.h),

          CustomTextField(
            controller: password,
            icon: Icons.lock_outline,
            hintText: 'Enter password',
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: onTogglePassword,
              icon: Icon(
                hidePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),

          if (errorMessage != null) ...[
            SizedBox(height: AppSpacing.sm.h),
            Center(
              child: Text(
                errorMessage!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],

          SizedBox(height: AppSpacing.xxl.h),

          /// Login button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: isLoading ? null : onLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                elevation: 5,
                shadowColor: AppColors.primary.withValues(alpha: 0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Login',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),

          SizedBox(height: AppSpacing.xl.h),

          /// Divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
                child: Text(
                  'or',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),

          SizedBox(height: AppSpacing.md.h),

          /// Create account
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Don't have an account? Create one",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
