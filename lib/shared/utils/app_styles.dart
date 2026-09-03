import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Application-wide color tokens.
///
/// Keep colors that are reused across screens here. Component-specific colors
/// should remain local to the component that owns them.
abstract final class AppColors {
  static const primary = Colors.deepPurple;
  static const onPrimary = Colors.white;
  static const surface = Colors.white;
  static const surfaceMuted = Color(0xFFF2F2F2);
  static const border = Colors.black;
  static const inactive = Colors.grey;
  static const textMuted = Color(0xFF9CA3AF);
  static const textPrimary = Color(0xFF374151);
  static const highlightSurface = Colors.black;
}

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

  static TextStyle get displayLarge => _base(
    fontSize: 84.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 4,
    height: 1.1,
  );

  /// Backwards-compatible color aliases. Prefer [AppColors] in new code.
  static Color get bgColor => AppColors.primary;
  static Color get titleColor => AppColors.onPrimary;
  static Color get bgBoxColor => AppColors.surface;

  static TextStyle get headingLarge =>
      _base(fontSize: 24.sp, fontWeight: FontWeight.bold, height: 1.2);

  static TextStyle get headingMedium =>
      _base(fontSize: 22.sp, fontWeight: FontWeight.w700, height: 1.2);

  static TextStyle get headingSmall =>
      _base(fontSize: 18.sp, fontWeight: FontWeight.w600, height: 1.2);

  static TextStyle get titleLarge =>
      _base(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get titleMedium =>
      _base(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 1.3);

  static TextStyle get bodyLarge =>
      _base(fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.4);

  static TextStyle get bodyMedium =>
      _base(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 1.4);

  static TextStyle get labelLarge => _base(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
    height: 1.2,
  );

  static TextStyle get labelSmall => _base(
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: .5,
    height: 1.2,
  );

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
}

/// A spacing token that can be scaled for a horizontal, vertical, or general
/// dimension. Use `.w` for width/padding, `.h` for height/gaps, and `.r` for
/// general square dimensions. Do not turn a genuinely one-off measurement into
/// a global token.
///
/// Example: `SizedBox(height: AppSpacing.xl.h)`.
class AppSpace {
  const AppSpace(this._value);

  final double _value;

  double get w => _value.w;
  double get h => _value.h;
  double get r => _value.r;
}

/// Application-wide responsive spacing scale.
///
/// Prefer these names for repeated layout gaps and padding. The scale preserves
/// the values already used by the application and uses `flutter_screenutil` at
/// the point of use.
abstract final class AppSpacing {
  static const xxs = AppSpace(4);
  static const xs = AppSpace(6);
  static const sm = AppSpace(8);
  static const md = AppSpace(10);
  static const lg = AppSpace(12);
  static const xl = AppSpace(20);
  static const xxl = AppSpace(24);
  static const xxxl = AppSpace(30);
  static const section = AppSpace(40);
  static const control = AppSpace(60);
  static const topSection = AppSpace(90);
  static const bottomSection = AppSpace(110);
  static const profileImgSize = AppSpace(100);

  /// Standard top inset for page content below the app bar.
  ///
  /// This is a getter because [xxl.h] is calculated responsively at runtime.
  static EdgeInsets get pagePadding => EdgeInsets.fromLTRB(0, xxl.h, 0, 0);
}

/// Application-wide responsive corner radii.
///
/// Use these for shared rounded surfaces, for example:
/// `BorderRadius.circular(AppRadius.medium)`. Keep a radius local when it is
/// specific to one component rather than a reusable design decision.
abstract final class AppRadius {
  static double get small => 4.r;
  static double get medium => 5.r;
  static double get large => 20.r;
  static double get extraLarge => 40.r;
  static double get extraLarge2 => 50.r;
}
