import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/features/user/widgets/initialization/initialization_field.dart';

class AboutYouStep extends StatelessWidget {
  const AboutYouStep({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a little more information about yourself.',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        InitializationField(
          label: 'Description',
          hint: 'Tell us something about yourself...',
          controller: descriptionController,
        ),

        SizedBox(height: AppSpacing.lg.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.lg.r),
          decoration: BoxDecoration(
            border: Border.all(
              color: colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
          child: Column(
            children: [
              Icon(
                Icons.person_outline,
                size: 48.r,
                color: colorScheme.onSurfaceVariant,
              ),

              SizedBox(height: AppSpacing.sm.h),

              Text(
                'Profile Image',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: AppSpacing.xs.h),

              Text(
                'Profile image upload will be added later.',
                style: textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}