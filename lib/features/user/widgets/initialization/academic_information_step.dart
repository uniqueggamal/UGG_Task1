import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/widgets/cutom_textfield/custom_textfield.dart';
import 'package:internship_task/core/widgets/cutom_textfield/models/custom_textfield_model.dart';
import 'package:internship_task/features/user/widgets/initialization/initialization_dropdown.dart';

class AcademicInformationStep extends StatelessWidget {
  const AcademicInformationStep({
    super.key,
    required this.selectedRole,
    required this.selectedStatus,
    required this.customRoleController,
    required this.customStatusController,
    required this.organizationController,
    required this.onRoleChanged,
    required this.onStatusChanged,
  });

  final String? selectedRole;
  final String? selectedStatus;

  final TextEditingController customRoleController;
  final TextEditingController customStatusController;
  final TextEditingController organizationController;

  final ValueChanged<String?> onRoleChanged;
  final ValueChanged<String?> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell us about your current role and academic status.',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        // --------------------------------------------------
        // Role
        // --------------------------------------------------
        _buildRoleField(),

        if (selectedRole == 'Other') ...[
          SizedBox(height: AppSpacing.md.h),

          _buildFieldLabel(context, 'Please specify your role'),

          SizedBox(height: AppSpacing.sm.h),

          CustomTextField(
            model: CustomTextFieldModel(
              controller: customRoleController,
              hintText: 'e.g. Researcher, Freelancer...',
              textInputAction: TextInputAction.next,
            ),
          ),
        ],

        SizedBox(height: AppSpacing.md.h),

        // --------------------------------------------------
        // Current Status
        // --------------------------------------------------
        _buildStatusField(),

        if (selectedStatus == 'Other') ...[
          SizedBox(height: AppSpacing.md.h),

          _buildFieldLabel(context, 'Please specify your status'),

          SizedBox(height: AppSpacing.sm.h),

          CustomTextField(
            model: CustomTextFieldModel(
              controller: customStatusController,
              hintText: 'Type your status here',
              textInputAction: TextInputAction.next,
            ),
          ),
        ],

        SizedBox(height: AppSpacing.md.h),

        // --------------------------------------------------
        // Affiliated Organization
        // --------------------------------------------------
        _buildFieldLabel(context, 'Affiliated Organization'),

        SizedBox(height: AppSpacing.sm.h),

        CustomTextField(
          model: CustomTextFieldModel(
            controller: organizationController,
            hintText: 'NCCS',
            textInputAction: TextInputAction.done,
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(BuildContext context, String label) {
    final theme = Theme.of(context);

    return Text(label, style: theme.textTheme.labelLarge);
  }

  Widget _buildRoleField() {
    return InitializationDropdown<String>(
      label: 'Role',
      value: selectedRole,
      required: true,
      items: const [
        DropdownMenuItem(value: 'Student', child: Text('Student')),
        DropdownMenuItem(value: 'Developer', child: Text('Developer')),
        DropdownMenuItem(value: 'Designer', child: Text('Designer')),
        DropdownMenuItem(value: 'Intern', child: Text('Intern')),
        DropdownMenuItem(value: 'Other', child: Text('Other')),
      ],
      onChanged: onRoleChanged,
    );
  }

  Widget _buildStatusField() {
    return InitializationDropdown<String>(
      label: 'Current Status',
      value: selectedStatus,
      required: true,
      items: const [
        DropdownMenuItem(value: 'Student', child: Text('Student')),
        DropdownMenuItem(
          value: 'Looking for Job',
          child: Text('Looking for Job'),
        ),
        DropdownMenuItem(value: 'Employed', child: Text('Employed')),
        DropdownMenuItem(value: 'Unemployed', child: Text('Unemployed')),
        DropdownMenuItem(value: 'Intern', child: Text('Intern')),
        DropdownMenuItem(value: 'Graduated', child: Text('Graduated')),
        DropdownMenuItem(value: 'Other', child: Text('Other')),
      ],
      onChanged: onStatusChanged,
    );
  }
}
