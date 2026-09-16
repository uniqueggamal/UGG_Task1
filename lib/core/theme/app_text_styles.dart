import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Font families registered in `pubspec.yaml`.
abstract final class AppFontFamilies {
  static const nunito = 'Nunito';
  static const notoSansDevanagari = 'NotoSansDevanagari';
}

/// Application-wide typography system.
///
/// Use these semantic styles for text that has a shared visual role instead of
/// creating `TextStyle` objects with raw font sizes in screens. Colors that are
/// specific to a component should be applied with `copyWith`.
///
/// Example: `Text('Welcome', style: AppTextStyles.headingLarge)`.
abstract final class AppTextStyles {
  static const _fontFamily = AppFontFamilies.notoSansDevanagari;

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Display
  static TextStyle get displayLarge => _base(
    fontSize: 84.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 4,
    height: 1.1,
  );

  // Headings
  static TextStyle get headingLarge =>
      _base(fontSize: 24.sp, fontWeight: FontWeight.bold, height: 1.2);

  static TextStyle get headingMedium =>
      _base(fontSize: 22.sp, fontWeight: FontWeight.w700, height: 1.2);

  static TextStyle get headingSmall =>
      _base(fontSize: 18.sp, fontWeight: FontWeight.w600, height: 1.2);

  // Titles
  static TextStyle get titleLarge =>
      _base(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get titleMedium =>
      _base(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 1.3);

  static TextStyle get titleSmall =>
      _base(fontSize: 12.sp, fontWeight: FontWeight.w500, height: 1.3);

  // Body
  static TextStyle get bodyLarge =>
      _base(fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.4);

  static TextStyle get bodyMedium =>
      _base(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 1.4);

  static TextStyle get bodySmall =>
      _base(fontSize: 12.sp, fontWeight: FontWeight.w400, height: 1.4);

  // Labels
  static TextStyle get labelLarge => _base(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
    height: 1.2,
  );

  static TextStyle get labelMedium => _base(
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    height: 1.2,
  );

  static TextStyle get labelSmall => _base(
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: .5,
    height: 1.2,
  );
}
