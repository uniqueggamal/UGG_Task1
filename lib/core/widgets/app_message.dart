import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';

enum MessageType { success, error, warning, info }

enum MessagePosition {
  topLeft,
  topCenter,
  topRight,
  center,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

class AppMessage {
  static Widget positionedMessage(MessagePosition position, Widget child) {
    switch (position) {
      case MessagePosition.topLeft:
        return Positioned(top: 10, left: 10, child: child);

      case MessagePosition.topCenter:
        return Positioned(top: 10, left: 10, right: 10, child: child);

      case MessagePosition.topRight:
        return Positioned(top: 10, right: 10, child: child);

      case MessagePosition.center:
        return Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(child: child),
        );

      case MessagePosition.bottomLeft:
        return Positioned(bottom: 10, left: 10, child: child);

      case MessagePosition.bottomCenter:
        return Positioned(bottom: 10, left: 10, right: 10, child: child);

      case MessagePosition.bottomRight:
        return Positioned(bottom: 10, right: 10, child: child);
    }
  }

  static Widget messageSection(
    String message,
    IconData? icon,
    MessageType type,
  ) {
    final Color typeColor = switch (type) {
      MessageType.success => AppColors.success,
      MessageType.error => AppColors.error,
      MessageType.warning => AppColors.warning,
      MessageType.info => AppColors.textPrimary,
    };

    final IconData typeIcon = switch (type) {
      MessageType.success => Icons.check_circle,
      MessageType.error => Icons.error,
      MessageType.warning => Icons.warning,
      MessageType.info => Icons.info,
    };

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 300.w,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.xl.w,
          vertical: AppSpacing.xl.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(color: typeColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon ?? typeIcon, color: typeColor),
            SizedBox(width: AppSpacing.md.w),
            Expanded(child: Text(message, style: AppTextStyles.bodyMedium)),
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String message,
    required MessageType type,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    MessagePosition position = MessagePosition.topRight,
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return positionedMessage(position, messageSection(message, icon, type));
      },
    );

    overlay.insert(entry);

    Future.delayed(duration, () {
      if (entry.mounted) {
        entry.remove();
      }
    });
  }
}
