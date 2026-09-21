import 'package:flutter/material.dart';

import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/features/user/widgets/initialization/initialization_dropdown.dart';
import 'package:internship_task/features/user/widgets/initialization/initialization_field.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell us about your current role and academic status.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        _buildRoleField(),

        if (selectedRole == 'Other') ...[
          SizedBox(height: AppSpacing.md.h),

          InitializationField(
            label: 'Please specify your role',
            hint: 'e.g. Researcher, Freelancer...',
            controller: customRoleController,
          ),
        ],

        SizedBox(height: AppSpacing.md.h),

        _buildStatusField(),

        if (selectedStatus == 'Other') ...[
          SizedBox(height: AppSpacing.md.h),

          InitializationField(
            label: 'Please specify your status',
            hint: 'Type your status here',
            controller: customStatusController,
          ),
        ],

        SizedBox(height: AppSpacing.md.h),

        InitializationField(
          label: 'Affiliated Organization',
          hint: 'NCCS',
          controller: organizationController,
        ),
      ],
    );
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
