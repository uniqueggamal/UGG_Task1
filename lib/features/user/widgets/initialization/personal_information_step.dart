import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/widgets/cutom_textfield/custom_textfield.dart';
import 'package:internship_task/core/widgets/cutom_textfield/models/custom_textfield_model.dart';

class PersonalInformationStep extends StatelessWidget {
  const PersonalInformationStep({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.locationController,
    required this.dateOfBirth,
    required this.onSelectDate,

    // Name field state
    required this.nameState,
    required this.nameMessage,
    required this.onNameChanged,

    // Phone field state
    required this.phoneState,
    required this.phoneMessage,
    required this.onPhoneChanged,

    // Location field state
    required this.locationState,
    required this.locationMessage,
    required this.onLocationChanged,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController locationController;

  final DateTime? dateOfBirth;
  final VoidCallback onSelectDate;

  // --------------------------------------------------
  // Name validation
  // --------------------------------------------------

  final FieldState nameState;
  final String? nameMessage;
  final ValueChanged<String> onNameChanged;

  // --------------------------------------------------
  // Phone validation
  // --------------------------------------------------

  final FieldState phoneState;
  final String? phoneMessage;
  final ValueChanged<String> onPhoneChanged;

  // --------------------------------------------------
  // Location validation
  // --------------------------------------------------

  final FieldState locationState;
  final String? locationMessage;
  final ValueChanged<String> onLocationChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell us a little about yourself.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        // --------------------------------------------------
        // Profile Picture
        // --------------------------------------------------

        Center(
          child: Column(
            children: [
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.surfaceContainerHighest,
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 48.r,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              SizedBox(height: AppSpacing.sm.h),

              TextButton.icon(
                onPressed: () {
                  // TODO: Add image picker.
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Change photo'),
              ),
            ],
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        // --------------------------------------------------
        // Full Name
        // --------------------------------------------------

        _buildFieldLabel(context, 'Full Name'),

        SizedBox(height: AppSpacing.sm.h),

        CustomTextField(
          model: CustomTextFieldModel(
            controller: nameController,
            hintText: 'Enter your full name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            state: nameState,
            message: nameMessage,
            onChanged: onNameChanged,
          ),
        ),

        SizedBox(height: AppSpacing.md.h),

        // --------------------------------------------------
        // Date of Birth
        // --------------------------------------------------

        _buildDateOfBirthField(context),

        SizedBox(height: AppSpacing.md.h),

        // --------------------------------------------------
        // Phone
        // --------------------------------------------------

        _buildFieldLabel(context, 'Phone'),

        SizedBox(height: AppSpacing.sm.h),

        CustomTextField(
          model: CustomTextFieldModel(
            controller: phoneController,
            hintText: '+977 98XXXXXXXX',
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            state: phoneState,
            message: phoneMessage,
            onChanged: onPhoneChanged,
          ),
        ),

        SizedBox(height: AppSpacing.md.h),

        // --------------------------------------------------
        // Location
        // --------------------------------------------------

        _buildFieldLabel(context, 'Location'),

        SizedBox(height: AppSpacing.sm.h),

        CustomTextField(
          model: CustomTextFieldModel(
            controller: locationController,
            hintText: 'Kathmandu, Nepal',
            keyboardType: TextInputType.streetAddress,
            textInputAction: TextInputAction.done,
            state: locationState,
            message: locationMessage,
            onChanged: onLocationChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(BuildContext context, String label) {
    final theme = Theme.of(context);

    return Text(
      label,
      style: theme.textTheme.labelLarge,
    );
  }

  Widget _buildDateOfBirthField(BuildContext context) {
    final theme = Theme.of(context);

    final dateText = dateOfBirth == null
        ? 'Select your date of birth'
        : '${dateOfBirth!.day.toString().padLeft(2, '0')}/'
              '${dateOfBirth!.month.toString().padLeft(2, '0')}/'
              '${dateOfBirth!.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of Birth',
          style: theme.textTheme.labelLarge,
        ),

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
                color: dateOfBirth == null
                    ? theme.hintColor
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

