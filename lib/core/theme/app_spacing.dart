import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  static const bottomSection = AppSpace(80);
  static const profileImgSize = AppSpace(100);
  static const buttonHeight1 = AppSpace(52);

  /// Standard top inset for page content below the app bar.
  ///
  /// This is a getter because [xxl.h] is calculated responsively at runtime.
  static EdgeInsets get pagePadding => EdgeInsets.fromLTRB(0, xxl.h, 0, 0);
}

