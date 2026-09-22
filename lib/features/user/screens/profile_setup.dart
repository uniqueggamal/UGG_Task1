import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/constants/routes.dart';
import 'package:provider/provider.dart';

import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/core/utils/validators.dart';
import 'package:internship_task/core/widgets/app_message.dart';
import 'package:internship_task/core/widgets/cutom_textfield/models/custom_textfield_model.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/user/models/user_model.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';
import 'package:internship_task/features/user/providers/user_provider.dart';
import 'package:internship_task/features/user/widgets/initialization/about_you_step.dart';
import 'package:internship_task/features/user/widgets/initialization/academic_information_step.dart';
import 'package:internship_task/features/user/widgets/initialization/initialization_navigation.dart';
import 'package:internship_task/features/user/widgets/initialization/initialization_progress.dart';
import 'package:internship_task/features/user/widgets/initialization/personal_information_step.dart';

class ProfileSetup extends StatefulWidget {
  final UserModel? user;
  final UserProfileModel? profile;

  const ProfileSetup({super.key, this.user, this.profile});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _organizationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _customRoleController = TextEditingController();
  final _customStatusController = TextEditingController();

  // ============================================================
  // STATE
  // ============================================================

  int _currentStep = 0;
  bool _isSaving = false;

  DateTime? _dateOfBirth;
  String? _selectedRole;
  String? _selectedStatus;

  // ------------------------------------------------------------
  // Name
  // ------------------------------------------------------------

  FieldState _nameState = FieldState.normal;
  String? _nameMessage;

  // ------------------------------------------------------------
  // Phone
  // ------------------------------------------------------------

  FieldState _phoneState = FieldState.normal;
  String? _phoneMessage;

  // ------------------------------------------------------------
  // Location
  // ------------------------------------------------------------

  FieldState _locationState = FieldState.normal;
  String? _locationMessage;

  // ------------------------------------------------------------
  // Step titles
  // ------------------------------------------------------------

  final List<String> _stepTitles = const [
    'Personal Information',
    'Current / Academic',
    'About You',
  ];

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void initState() {
    super.initState();

    _loadExistingData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    _customRoleController.dispose();
    _customStatusController.dispose();

    super.dispose();
  }

  // ============================================================
  // LOAD EXISTING DATA
  // ============================================================

  void _loadExistingData() {
    final user = widget.user;
    final profile = widget.profile;

    // ------------------------------------------------------------
    // Account information
    // ------------------------------------------------------------

    if (user != null) {
      _nameController.text = user.name;
    }

    // ------------------------------------------------------------
    // Profile information
    // ------------------------------------------------------------

    if (profile == null) return;

    _phoneController.text = profile.phone ?? '';
    _locationController.text = profile.location ?? '';
    _organizationController.text = profile.affiliatedOrganization ?? '';
    _descriptionController.text = profile.description ?? '';

    _dateOfBirth = profile.dateOfBirth == null
        ? null
        : DateTime.tryParse(profile.dateOfBirth!);

    _setRole(profile.role);
    _setStatus(profile.currentStatus);
  }

  // ============================================================
  // ROLE
  // ============================================================

  void _setRole(String? role) {
    if (role == null || role.isEmpty) {
      _selectedRole = null;
      return;
    }

    const predefinedRoles = [
      'Student',
      'Employee',
      'Teacher',
      'Developer',
      'Other',
    ];

    if (predefinedRoles.contains(role)) {
      _selectedRole = role;
    } else {
      _selectedRole = 'Other';
      _customRoleController.text = role;
    }
  }

  // ============================================================
  // STATUS
  // ============================================================

  void _setStatus(String? status) {
    if (status == null || status.isEmpty) {
      _selectedStatus = null;
      return;
    }

    const predefinedStatuses = [
      'Student',
      'Employed',
      'Unemployed',
      'Graduated',
      'Other',
    ];

    if (predefinedStatuses.contains(status)) {
      _selectedStatus = status;
    } else {
      _selectedStatus = 'Other';
      _customStatusController.text = status;
    }
  }

  // ============================================================
  // DATE OF BIRTH
  // ============================================================

  Future<void> _selectDateOfBirth() async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: _dateOfBirth ?? DateTime(2000),
    );

    if (selectedDate == null) return;

    setState(() {
      _dateOfBirth = selectedDate;
    });
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _continue() {
    if (!_validateCurrentStep()) return;

    if (_currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _saveProfile();
    }
  }

  void _back() {
    if (_currentStep == 0) return;

    setState(() {
      _currentStep--;
    });
  }

  // ============================================================
  // VALIDATION
  // ============================================================

  bool _validateCurrentStep() {
    // ------------------------------------------------------------
    // Personal Information
    // ------------------------------------------------------------

    if (_currentStep == 0) {
      // Name
      final nameError = Validators.validateName(_nameController.text);

      if (nameError != null) {
        setState(() {
          _nameState = FieldState.error;
          _nameMessage = nameError;
        });

        return false;
      }

      // Phone
      final phoneError = Validators.validatePhone(_phoneController.text);

      if (phoneError != null) {
        setState(() {
          _phoneState = FieldState.error;
          _phoneMessage = phoneError;
        });

        return false;
      }

      // Location
      final locationError = Validators.validateLocation(
        _locationController.text,
      );

      if (locationError != null) {
        setState(() {
          _locationState = FieldState.error;
          _locationMessage = locationError;
        });

        return false;
      }
    }

    // ------------------------------------------------------------
    // Current / Academic
    // ------------------------------------------------------------

    if (_currentStep == 1) {
      if (_selectedRole == null || _selectedStatus == null) {
        AppMessage.show(
          context,
          message: 'Please complete the required fields.',
          type: MessageType.warning,
        );

        return false;
      }

      if (_selectedRole == 'Other' &&
          _customRoleController.text.trim().isEmpty) {
        AppMessage.show(
          context,
          message: 'Please enter your role.',
          type: MessageType.warning,
        );

        return false;
      }

      if (_selectedStatus == 'Other' &&
          _customStatusController.text.trim().isEmpty) {
        AppMessage.show(
          context,
          message: 'Please enter your current status.',
          type: MessageType.warning,
        );

        return false;
      }
    }

    return true;
  }

  // ============================================================
  // FIELD CHANGES
  // ============================================================

  void _onNameChanged(String value) {
    final formatted = Validators.capitalizeWords(value);

    if (formatted != value) {
      _nameController.value = _nameController.value.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    // Only validate while typing if an error is already visible.
    if (_nameState == FieldState.error) {
      final error = Validators.validateName(formatted);

      setState(() {
        _nameState = error == null ? FieldState.normal : FieldState.error;

        _nameMessage = error;
      });
    }
  }

  void _onPhoneChanged(String value) {
    // Phone is optional.
    // Only validate while typing after an error is visible.
    if (_phoneState == FieldState.error) {
      final error = Validators.validatePhone(value);

      setState(() {
        _phoneState = error == null ? FieldState.normal : FieldState.error;

        _phoneMessage = error;
      });
    }
  }

  void _onLocationChanged(String value) {
    // Location is optional.
    // Only validate while typing after an error is visible.
    if (_locationState == FieldState.error) {
      final error = Validators.validateLocation(value);

      setState(() {
        _locationState = error == null ? FieldState.normal : FieldState.error;

        _locationMessage = error;
      });
    }
  }

  // ============================================================
  // ROLE / STATUS CHANGES
  // ============================================================

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

  // ============================================================
  // SAVE
  // ============================================================

  Future<void> _saveProfile() async {
    if (_isSaving) return;

    final authProvider = context.read<AuthProvider>();
    final userProvider = context.read<UserProvider>();

    final token = authProvider.token;

    if (token == null) {
      AppMessage.show(
        context,
        message: 'Authentication token not found. Please login again.',
        type: MessageType.error,
      );

      // userProvider.updateProfile(token: token!, model: model);
      return;
    }

    // ------------------------------------------------------------
    // Resolve role
    // ------------------------------------------------------------

    final role = _selectedRole == 'Other'
        ? _customRoleController.text.trim()
        : _selectedRole;

    // ------------------------------------------------------------
    // Resolve current status
    // ------------------------------------------------------------

    final currentStatus = _selectedStatus == 'Other'
        ? _customStatusController.text.trim()
        : _selectedStatus;

    // ------------------------------------------------------------
    // Create profile model
    // ------------------------------------------------------------

    final profile = UserProfileModel(
      role: role,
      currentStatus: currentStatus,

      affiliatedOrganization: _organizationController.text.trim().isEmpty
          ? null
          : _organizationController.text.trim(),

      dateOfBirth: _dateOfBirth == null
          ? null
          : '${_dateOfBirth!.year}-'
                '${_dateOfBirth!.month.toString().padLeft(2, '0')}-'
                '${_dateOfBirth!.day.toString().padLeft(2, '0')}',

      phone: _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),

      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),

      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
    );

    final user = UserModel(
      id: widget.user?.id ?? 0,
      name: _nameController.text.trim(),
      email: widget.user?.email ?? '',
    );

    setState(() {
      _isSaving = true;
    });

    try {
      // Save profile information.
      await userProvider.updateUser(token: token, user: user);
      await userProvider.updateProfile(token: token, profile: profile);

      if (!mounted) return;

      AppMessage.show(
        context,
        message: widget.profile == null
            ? 'Profile initialized successfully.'
            : 'Profile updated successfully.',
        type: MessageType.success,
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      AppMessage.show(context, message: e.toString(), type: MessageType.error);
    } finally {
      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });
    }
  }

  // ============================================================
  // CURRENT STEP
  // ============================================================

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return PersonalInformationStep(
          nameController: _nameController,
          phoneController: _phoneController,
          locationController: _locationController,
          dateOfBirth: _dateOfBirth,
          onSelectDate: _selectDateOfBirth,

          // Name
          nameState: _nameState,
          nameMessage: _nameMessage,
          onNameChanged: _onNameChanged,

          // Phone
          phoneState: _phoneState,
          phoneMessage: _phoneMessage,
          onPhoneChanged: _onPhoneChanged,

          // Location
          locationState: _locationState,
          locationMessage: _locationMessage,
          onLocationChanged: _onLocationChanged,
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

  Future<void> _confirmCancel() async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cancel profile setup?', style: AppTextStyles.titleLarge),
          content: Text(
            'Your changes will not be saved. Are you sure you want to leave?',
            style: AppTextStyles.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Continue Editing'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.profile),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );

    if (shouldCancel == true && mounted) {
      Navigator.pop(context);
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.profile != null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        await _confirmCancel();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          automaticallyImplyLeading: false,

          leading: widget.profile != null
              ? IconButton(
                  onPressed: () => _confirmCancel(),
                  icon: const Icon(Icons.arrow_back),
                  color: AppColors.onPrimary,
                  iconSize: 24,
                  tooltip: 'Back',
                )
              : null,

          title: Text(
            isEditing ? 'Edit Profile' : 'Set Up Profile',
            style: AppTextStyles.headingLarge.copyWith(
              letterSpacing: 1.5,
              color: AppColors.onPrimary,
            ),
          ),
        ),
        backgroundColor: AppColors.surfaceMuted,

        body: SafeArea(
          child: Column(
            children: [
              // ----------------------------------------------------
              // Progress
              // ----------------------------------------------------
              InitializationProgress(
                currentStep: _currentStep,
                stepTitles: _stepTitles,
              ),

              // ----------------------------------------------------
              // Current step
              // ----------------------------------------------------
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.lg.r),
                  child: _buildCurrentStep(),
                ),
              ),

              // ----------------------------------------------------
              // Navigation
              // ----------------------------------------------------
              InitializationNavigation(
                currentStep: _currentStep,
                totalSteps: _stepTitles.length,
                onBack: _back,
                onContinue: _continue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
