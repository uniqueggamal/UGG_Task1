// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:internship_task/core/theme/app_text_styles.dart';
// import '../../../../core/widgets/text_field.dart';

// /// Reusable labeled text field widget for authentication forms
// class LabeledTextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final IconData? icon;
//   final String hintText;
//   final bool obscureText;
//   final Widget? suffixIcon;
//   final bool isLoading;
//   final TextStyle? labelStyle;
//   final double labelFieldSpacing;

//   const LabeledTextField({
//     super.key,
//     required this.label,
//     required this.controller,
//     this.icon,
//     required this.hintText,
//     this.obscureText = false,
//     this.suffixIcon,
//     this.isLoading = false,
//     this.labelStyle,
//     required this.labelFieldSpacing,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style:
//               labelStyle ??
//               AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: labelFieldSpacing),
//         CustomTextField(
//           controller: controller,
//           icon: icon!,
//           hintText: hintText,
//           obscureText: obscureText,
//           suffixIcon: suffixIcon,
//           isLoading: isLoading,
//         ),
//       ],
//     );
//   }
// }
