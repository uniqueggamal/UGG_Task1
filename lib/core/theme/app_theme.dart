import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_radius.dart';
import 'app_dimensions.dart';

/// Centralized theme configuration for the application.
///
/// This file connects the design tokens to Flutter's global theme system.
abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.onPrimary,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.surface,

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineLarge: AppTextStyles.headingLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTextStyles.headingMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineSmall: AppTextStyles.headingSmall.copyWith(
          color: AppColors.textPrimary,
        ),
        titleLarge: AppTextStyles.titleLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        titleMedium: AppTextStyles.titleMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        titleSmall: AppTextStyles.titleSmall.copyWith(
          color: AppColors.textMuted,
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
        labelLarge: AppTextStyles.labelLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          color: AppColors.textMuted,
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(
          color: AppColors.textMuted,
        ),
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: AppDimensions.appBarHeight,
        titleTextStyle: AppTextStyles.headingLarge.copyWith(
          color: AppColors.textPrimary,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        errorStyle: const TextStyle(color: AppColors.error),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: Size(double.infinity, AppDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
          shadowColor: AppColors.primary.withValues(alpha: 0.35),
          elevation: 4,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: Size(double.infinity, AppDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
          side: const BorderSide(color: AppColors.primary),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),
    );
  }
}
