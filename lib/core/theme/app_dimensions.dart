import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Application-wide reusable component dimensions.
///
/// Use this only for reusable component dimensions that are currently scattered
/// around the application.
abstract final class AppDimensions {
  // Controls
  static double get buttonHeight => 52.h;
  static double get inputHeight => 52.h;

  // Icons
  static double get iconSmall => 16.r;
  static double get iconMedium => 20.r;
  static double get iconLarge => 24.r;
  static double get iconXLarge => 32.r;

  // Images
  static double get profileImgSize => 100.r;
  static double get avatarSmall => 40.r;
  static double get avatarMedium => 56.r;
  static double get avatarLarge => 80.r;
  static double get avatarXLarge => 100.r;

  // Navigation
  static double get bottomNavHeight => 64.h;
  static double get appBarHeight => 56.h;
}

