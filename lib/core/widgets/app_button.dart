import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';

/// Reusable primary action button for authentication forms
/// Supports loading state
class AppButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final Color? shadowColor;
  final double borderRadius;
  final Widget? loadingIndicator;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 5,
    this.shadowColor,
    required this.borderRadius,
    this.loadingIndicator,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: foregroundColor ?? AppColors.onPrimary,
          elevation: elevation,
          shadowColor: shadowColor ?? AppColors.primary.withValues(alpha: 0.35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
        ),
        child: isLoading
            ? (loadingIndicator ??
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.grey,
                    ),
                  ))
            : Text(
                text,
                style:
                    textStyle ??
                    AppTextStyles.bodyLarge.copyWith(
                      color: foregroundColor ?? AppColors.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
      ),
    );
  }
}
