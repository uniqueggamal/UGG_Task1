import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/features/user/models/full_profile_model.dart';
import 'package:internship_task/features/user/models/user_model.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';

class NameSection extends StatelessWidget {
  const NameSection({super.key, required this.user, this.profile});

  final UserModel user;
  final UserProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    final name = user.name.trim();
    final role = profile?.role?.trim();

    return Column(
      children: [
        Text(
          name.isNotEmpty ? name : 'Name not provided',
          textAlign: TextAlign.center,
          style: AppTextStyles.headingLarge.copyWith(letterSpacing: 1.5),
        ),

        if (role != null && role.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            role,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleLarge.copyWith(
              letterSpacing: 1,
              fontWeight: FontWeight.w400,
              fontSize: 24.sp,
            ),
          ),
        ],
      ],
    );
  }
}
