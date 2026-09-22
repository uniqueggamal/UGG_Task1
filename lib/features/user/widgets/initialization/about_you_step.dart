import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/widgets/cutom_textfield/custom_textfield.dart';
import 'package:internship_task/core/widgets/cutom_textfield/models/custom_textfield_model.dart';

class AboutYouStep extends StatelessWidget {
  const AboutYouStep({super.key, required this.descriptionController});

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

        // --------------------------------------------------
        // Description
        // --------------------------------------------------
        Text('Description', style: textTheme.labelLarge),

        SizedBox(height: AppSpacing.sm.h),

        CustomTextField(
          model: CustomTextFieldModel(
            controller: descriptionController,
            hintText: 'Tell us something about yourself...',
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 5,
          ),
        ),
      ],
    );
  }
}
