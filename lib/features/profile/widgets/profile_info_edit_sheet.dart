import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/core/theme/app_spacing.dart';

class ProfileInfoEditSheet extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController controller;
  final String? hintText;
  final int? maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const ProfileInfoEditSheet({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    this.hintText,
    this.maxLines = 4,
    this.keyboardType = TextInputType.multiline,
    this.validator,
  });
  Widget infoEditCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          children: [
            Icon(icon, size: 20.r),
            AppSpacing.sm.w.horizontalSpace,
            Text(title, style: AppTextStyles.bodyLarge),
          ],
        ),

        AppSpacing.md.h.verticalSpace,

        // Editable Field
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText ?? "Enter $title",
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey.shade400,
            ),
            border: OutlineInputBorder(
              // gapPadding: 0.0,
            ),
            isDense: true,
            // contentPadding: EdgeInsets,
          ),
        ),
        Row(
          children: [
            // ElevatedButton(onPressed: onPressed, child: child)
          ],
        ),
      ],
    );
  }

  Future<dynamic> editSheet(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return infoEditCard();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
