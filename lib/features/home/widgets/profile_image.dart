import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_styles.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xxs.r),
      decoration: BoxDecoration(border: Border.all(width: 0.1)),
      child: Image.asset("assets/pp.jpg", width: 175.h),
    );
  }
}
