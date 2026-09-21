import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/core/theme/app_spacing.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String title;
  final String imagePath;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSpacing.sm.w.horizontalSpace,

        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            shape: BoxShape.circle,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 80,
              minWidth: 80,
              maxHeight: 300,
              maxWidth: 300,
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        AppSpacing.sm.w.horizontalSpace,

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyles.headingLarge,
            ),
            SizedBox(height: AppSpacing.sm.h),
            Text(
              title,
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
