import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.profile});

  final UserProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    final imageUrl = profile?.profileImage;

    return Container(
      padding: EdgeInsets.all(AppSpacing.xxs.r),
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                width: 175.r,
                height: 175.r,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    'assets/pp.jpg',
                    width: 175.r,
                    height: 175.r,
                    fit: BoxFit.cover,
                  );
                },
              )
            : Image.asset(
                'assets/pp.jpg',
                width: 175.r,
                // height: 175.r,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
