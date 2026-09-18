// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:internship_task/core/theme/app_colors.dart';
// import 'package:internship_task/core/theme/app_radius.dart';
// import 'package:internship_task/core/theme/app_spacing.dart';
// import 'package:internship_task/core/theme/app_text_styles.dart';

// class LoadingScreen {
//   static Widget screen(String message, bool isLoading) {
//     final Color widgetColor = AppColors.inactive;


//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         width: 300.w,
//         padding: EdgeInsets.symmetric(
//           horizontal: AppSpacing.xl.w,
//           vertical: AppSpacing.xl.h,
//         ),
//         decoration: BoxDecoration(
//           color: AppColors.surface,
//           borderRadius: BorderRadius.circular(AppRadius.large),
//           border: Border.all(color: typeColor),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.12),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Icon(icon ?? typeIcon, color: typeColor),
//             SizedBox(width: AppSpacing.md.w),
//             Expanded(child: Text(message, style: AppTextStyles.bodyMedium)),
//           ],
//         ),
//       ),
//     );
//   }

//   static void show(
//     BuildContext context, {
//     required String message,
//     required MessageType type,
//     IconData? icon,
//     Duration duration = const Duration(seconds: 3),
//     MessagePosition position = MessagePosition.topRight,
//   }) {
//     final overlay = Overlay.of(context, rootOverlay: true);

//     late OverlayEntry entry;

//     entry = OverlayEntry(
//       builder: (context) {
//         return positionedMessage(position, messageSection(message, icon, type));
//       },
//     );

//     overlay.insert(entry);

//     Future.delayed(duration, () {
//       if (entry.mounted) {
//         entry.remove();
//       }
//     });
//   }
// }
