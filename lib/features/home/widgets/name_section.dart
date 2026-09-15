import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_styles.dart';

class NameSection extends StatelessWidget {
  const NameSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Unique G. Gamal",
          style: AppTextStyles.headingLarge.copyWith(letterSpacing: 1.5),
        ),
        Text(
          "Intern",
          style: AppTextStyles.titleLarge.copyWith(
            letterSpacing: 1,
            fontWeight: FontWeight.w400,
            fontSize: 24.sp,
          ),
        ),
      ],
    );
  }
}
