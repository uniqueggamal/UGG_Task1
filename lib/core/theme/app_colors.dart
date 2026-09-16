import 'package:flutter/material.dart';

/// Application-wide color tokens.
///
/// Keep colors that are reused across screens here. Component-specific colors
/// should remain local to the component that owns them.
abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF673AB7);
  static const onPrimary = Colors.white;

  // Surfaces
  static const surface = Colors.white;
  static const surfaceMuted = Color(0xFFF5F5F7);
  static const highlightSurface = Colors.black;

  // Text
  static const textPrimary = Color(0xFF374151);
  static const textMuted = Color(0xFF9CA3AF);
  static const textOnPrimary = Colors.white;

  // Borders
  static const border = Colors.black;

  // States
  static const error = Colors.red;
  static const warning = Colors.yellow;
  static const success = Colors.green;

  // Interaction
  static const inactive = Colors.grey;
}
