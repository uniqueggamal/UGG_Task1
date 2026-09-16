import 'package:flutter_screenutil/flutter_screenutil.dart';

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
