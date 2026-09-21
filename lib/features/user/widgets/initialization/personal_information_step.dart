import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/features/user/widgets/initialization/initialization_field.dart';

class PersonalInformationStep extends StatelessWidget {
  const PersonalInformationStep({
    super.key,
    required this.phoneController,
    required this.locationController,
    required this.dateOfBirth,
    required this.onSelectDate,
  });

  final TextEditingController phoneController;
  final TextEditingController locationController;

  final DateTime? dateOfBirth;
  final VoidCallback onSelectDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell us a little about your personal information.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        _buildDateOfBirthField(context),

        SizedBox(height: AppSpacing.md.h),

        InitializationField(
          label: 'Phone',
          hint: '+977 98XXXXXXXX',
          controller: phoneController,
          keyboardType: TextInputType.phone,
        ),

        SizedBox(height: AppSpacing.md.h),

        InitializationField(
          label: 'Location',
          hint: 'Kathmandu, Nepal',
          controller: locationController,
        ),
      ],
    );
  }

  Widget _buildDateOfBirthField(BuildContext context) {
    final dateText = dateOfBirth == null
        ? 'Select your date of birth'
        : '${dateOfBirth!.day.toString().padLeft(2, '0')}/'
              '${dateOfBirth!.month.toString().padLeft(2, '0')}/'
              '${dateOfBirth!.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date of Birth', style: Theme.of(context).textTheme.labelLarge),

        SizedBox(height: AppSpacing.sm.h),

        InkWell(
          onTap: onSelectDate,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          child: InputDecorator(
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.calendar_today_outlined),
            ),
            child: Text(
              dateText,
              style: TextStyle(
                color: dateOfBirth == null ? Theme.of(context).hintColor : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
