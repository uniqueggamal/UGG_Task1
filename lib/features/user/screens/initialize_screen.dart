import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/app/app_shell/base/screens/base_screen.dart';
import 'package:internship_task/core/constants/routes.dart';
import 'package:provider/provider.dart';

import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';
import 'package:internship_task/features/user/providers/user_provider.dart';

import 'package:internship_task/features/user/widgets/initialization/about_you_step.dart';
import 'package:internship_task/features/user/widgets/initialization/academic_information_step.dart';
import 'package:internship_task/features/user/widgets/initialization/initialization_navigation.dart';
import 'package:internship_task/features/user/widgets/initialization/initialization_progress.dart';
import 'package:internship_task/features/user/widgets/initialization/personal_information_step.dart';

class InitializeScreen extends StatefulWidget {
  const InitializeScreen({super.key});

  @override
  State<InitializeScreen> createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _organizationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _customRoleController = TextEditingController();
  final _customStatusController = TextEditingController();

  int _currentStep = 0;

  DateTime? _dateOfBirth;
  String? _selectedRole;
  String? _selectedStatus;

  final List<String> _stepTitles = const [
    'Personal Information',
    'Current / Academic',
    'About You',
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    _locationController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    _customRoleController.dispose();
    _customStatusController.dispose();

    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: DateTime(2000),
    );

    if (selectedDate == null) return;

    setState(() {
      _dateOfBirth = selectedDate;
    });
  }

  void _continue() async {
    if (!_validateCurrentStep()) return;

    if (_currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _initializeProfile();
    }
  }

  void _back() {
    if (_currentStep == 0) return;

    setState(() {
      _currentStep--;
    });
  }

  bool _validateCurrentStep() {
    if (_currentStep == 1) {
      if (_selectedRole == null || _selectedStatus == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete the required fields.')),
        );

        return false;
      }
    }

    return true;
  }

  Future<void> _initializeProfile() async {
    final authProvider = context.read<AuthProvider>();
    final userProvider = context.read<UserProvider>();

    final token = authProvider.token;

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication token not found. Please login again.'),
        ),
      );

      return;
    }

    final model = UserProfileModel(
      role: _selectedRole == 'Other'
          ? _customRoleController.text.trim()
          : _selectedRole,

      currentStatus: _selectedStatus == 'Other'
          ? _customStatusController.text.trim()
          : _selectedStatus,

      affiliatedOrganization: _organizationController.text.trim(),

      dateOfBirth: _dateOfBirth == null
          ? null
          : '${_dateOfBirth!.year}-'
                '${_dateOfBirth!.month.toString().padLeft(2, '0')}-'
                '${_dateOfBirth!.day.toString().padLeft(2, '0')}',

      phone: _phoneController.text.trim(),

      description: _descriptionController.text.trim(),

      location: _locationController.text.trim(),
    );

    try {
      await userProvider.updateProfile(token: token, model: model);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile initialized successfully')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _onRoleChanged(String? value) {
    setState(() {
      _selectedRole = value;

      if (value != 'Other') {
        _customRoleController.clear();
      }
    });
  }

  void _onStatusChanged(String? value) {
    setState(() {
      _selectedStatus = value;

      if (value != 'Other') {
        _customStatusController.clear();
      }
    });
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return PersonalInformationStep(
          phoneController: _phoneController,
          locationController: _locationController,
          dateOfBirth: _dateOfBirth,
          onSelectDate: _selectDateOfBirth,
        );

      case 1:
        return AcademicInformationStep(
          selectedRole: _selectedRole,
          selectedStatus: _selectedStatus,
          customRoleController: _customRoleController,
          customStatusController: _customStatusController,
          organizationController: _organizationController,
          onRoleChanged: _onRoleChanged,
          onStatusChanged: _onStatusChanged,
        );

      case 2:
        return AboutYouStep(descriptionController: _descriptionController);

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          InitializationProgress(
            currentStep: _currentStep,
            stepTitles: _stepTitles,
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacing.lg.r),
              child: _buildCurrentStep(),
            ),
          ),

          InitializationNavigation(
            currentStep: _currentStep,
            totalSteps: _stepTitles.length,
            onBack: _back,
            onContinue: _continue,
          ),
        ],
      ),
    );
  }
}
