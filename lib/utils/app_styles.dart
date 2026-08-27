import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shared responsive spacing values used throughout the app.
abstract final class AppSpacing {
  static double get v4 => 4.h;
  static double get v10 => 10.h;
  static double get v20 => 20.h;
  static double get v24 => 24.h;
  static double get v40 => 40.h;
  static double get v60 => 60.h;

  static double get h6 => 6.w;
  static double get h20 => 20.w;
  static double get h30 => 30.w;
}

/// Shared responsive corner-radius values used throughout the app.
abstract final class AppRadius {
  static double get r4 => 4.r;
  static double get r5 => 5.r;
}

/// Shared responsive text-size values used throughout the app.
abstract final class AppTextSizes {
  static double get s14 => 14.sp;
  static double get s16 => 16.sp;
  static double get s24 => 24.sp;
}
