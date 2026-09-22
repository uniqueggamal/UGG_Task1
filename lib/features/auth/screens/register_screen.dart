import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/constants/routes.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_dimensions.dart';
import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/utils/validators.dart';
import 'package:internship_task/core/widgets/app_button.dart';
import 'package:internship_task/core/widgets/app_message.dart';
import 'package:internship_task/core/widgets/cutom_textfield/custom_textfield.dart';
import 'package:internship_task/core/widgets/cutom_textfield/models/custom_textfield_model.dart';
import 'package:internship_task/features/auth/models/register_model.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/auth/services/auth_service.dart';
import 'package:internship_task/features/auth/widgets/background_items/auth_background.dart';
import 'package:internship_task/features/auth/widgets/form_items/auth_card.dart';
import 'package:internship_task/features/auth/widgets/form_items/auth_header.dart';
import 'package:provider/provider.dart';

enum EmailStatus {
  empty,
  invalid,
  validNotChecked,
  checking,
  available,
  registered,
  error,
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ============================================================
  // CONTROLLERS & FORM
  // ============================================================

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _authService = AuthService();

  // ============================================================
  // FIELD STATES
  // ============================================================

  FieldState _nameState = FieldState.normal;
  String? _nameMessage;

  FieldState _emailState = FieldState.normal;
  String? _emailMessage;

  FieldState _newPasswordState = FieldState.normal;
  String? _newPasswordMessage;

  FieldState _confirmPasswordState = FieldState.normal;
  String? _confirmPasswordMessage;

  // ============================================================
  // EMAIL STATE
  // ============================================================

  EmailStatus _emailStatus = EmailStatus.empty;
  bool _checkingEmail = false;

  // ============================================================
  // UI STATE
  // ============================================================

  bool _isLoading = false;

  bool _confirmPasswordObscure = true;
  bool _newPasswordObscure = true;

  static const registerTitle = 'Register';
  static const registerSubtitle = 'Create your account';

  // ============================================================
  // PAGE COUNTER
  // ============================================================

  int _counter = 1;

  void _addCount() {
    if (_counter < 2) {
      setState(() {
        _counter++;
      });
    }
  }

  void _subCount() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }

  // ============================================================
  // NAME VALIDATION
  // ============================================================

  void _validateName(String value) {
    final formattedName = Validators.capitalizeWords(value);

    if (formattedName != value) {
      _nameController.value = _nameController.value.copyWith(
        text: formattedName,
        selection: TextSelection.collapsed(offset: formattedName.length),
      );
    }

    final message = Validators.validateName(formattedName);

    setState(() {
      _nameMessage = message;
      _nameState = message == null ? FieldState.normal : FieldState.error;
    });
  }

  // ============================================================
  // EMAIL VALIDATION
  // ============================================================

  void _validateEmail(String value) {
    final email = value.trim();

    if (email.isEmpty) {
      setState(() {
        _emailStatus = EmailStatus.empty;
        _emailMessage = 'Email is required';
        _emailState = FieldState.error;
      });
      return;
    }

    final message = Validators.validateEmail(email);

    setState(() {
      if (message != null) {
        // Email format is invalid.
        _emailStatus = EmailStatus.invalid;
        _emailMessage = message;
        _emailState = FieldState.error;
      } else {
        // Email format is valid,
        // but we have not checked the server yet.
        _emailStatus = EmailStatus.validNotChecked;
        _emailMessage = null;
        _emailState = FieldState.normal;
      }
    });
  }

  // ============================================================
  // EMAIL AVAILABILITY CHECK
  // ============================================================

  Future<void> _checkEmailAndContinue() async {
    // ------------------------------------------------------------
    // Validate name first
    // ------------------------------------------------------------

    final nameMessage = Validators.validateName(_nameController.text);

    setState(() {
      _nameMessage = nameMessage;
      _nameState = nameMessage == null ? FieldState.normal : FieldState.error;
    });

    // Stop if name is invalid
    if (nameMessage != null) {
      return;
    }

    // ------------------------------------------------------------
    // Validate email
    // ------------------------------------------------------------

    final email = _emailController.text.trim();

    _validateEmail(email);

    // Stop if email format is invalid
    if (_emailStatus != EmailStatus.validNotChecked) {
      return;
    }

    // ------------------------------------------------------------
    // Check email availability
    // ------------------------------------------------------------

    setState(() {
      _emailStatus = EmailStatus.checking;
      _checkingEmail = true;
    });

    try {
      final exists = await _authService.checkEmail(email);

      if (!mounted) return;

      if (exists) {
        setState(() {
          _emailStatus = EmailStatus.registered;
          _emailState = FieldState.error;
          _emailMessage = 'Email is already registered';
        });

        AppMessage.show(
          context,
          message: 'Email is already registered',
          type: MessageType.warning,
        );

        return;
      }

      // Email is available
      setState(() {
        _emailStatus = EmailStatus.available;
        _emailState = FieldState.normal;
        _emailMessage = null;
      });

      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      _addCount();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _emailStatus = EmailStatus.error;
        _emailState = FieldState.error;
        _emailMessage = 'Could not verify email availability';
      });

      AppMessage.show(context, message: e.toString(), type: MessageType.error);
    } finally {
      if (!mounted) return;

      setState(() {
        _checkingEmail = false;
      });
    }
  }

  // ============================================================
  // NEW PASSWORD VALIDATION
  // ============================================================

  void _validateNewPassword(String value) {
    final message = Validators.validatePassword(value);

    setState(() {
      _newPasswordMessage = message;
      _newPasswordState = message == null
          ? FieldState.normal
          : FieldState.error;
    });

    // Re-check confirmation when password changes.
    if (_confirmPasswordController.text.isNotEmpty) {
      _validateConfirmPassword(_confirmPasswordController.text);
    }
  }

  // ============================================================
  // CONFIRM PASSWORD VALIDATION
  // ============================================================

  void _validateConfirmPassword(String value) {
    final message = Validators.validatePassword(value);

    final passwordsMatch = value == _newPasswordController.text;

    setState(() {
      if (message != null) {
        _confirmPasswordMessage = message;
        _confirmPasswordState = FieldState.error;
      } else if (!passwordsMatch) {
        _confirmPasswordMessage = 'Passwords do not match';
        _confirmPasswordState = FieldState.error;
      } else {
        _confirmPasswordMessage = null;
        _confirmPasswordState = FieldState.normal;
      }
    });
  }

  // ============================================================
  // REGISTER
  // ============================================================

  Future<void> _register() async {
    // Validate password fields.
    _validateNewPassword(_newPasswordController.text);

    _validateConfirmPassword(_confirmPasswordController.text);

    // Validate name.
    if (_nameController.text.trim().isEmpty) {
      setState(() {
        _nameState = FieldState.error;
        _nameMessage = 'Full name is required';
      });
    }

    // Email must have been confirmed as available.
    if (_emailStatus != EmailStatus.available) {
      AppMessage.show(
        context,
        message: 'Please verify that your email is available',
        type: MessageType.warning,
      );
      return;
    }

    // Validate all fields before sending the request.
    if (_nameMessage != null ||
        _newPasswordMessage != null ||
        _confirmPasswordMessage != null ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      AppMessage.show(
        context,
        message: 'Please fill the fields correctly',
        type: MessageType.error,
      );
      return;
    }

    final model = RegisterRequest(
      name: Validators.capitalizeWords(_nameController.text.trim()),
      email: _emailController.text.trim(),
      password: _newPasswordController.text,
      passwordConfirmation: _confirmPasswordController.text,
    );

    await register(model: model);
  }

  // ============================================================
  // API REGISTRATION
  // ============================================================

  Future<void> register({required RegisterRequest model}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<AuthProvider>().registerUser(model);

      if (!mounted) return;

      AppMessage.show(
        context,
        message: 'Registered Successfully',
        type: MessageType.success,
      );

      Navigator.pushNamed(context, AppRoutes.login);
    } catch (e) {
      if (!mounted) return;

      AppMessage.show(context, message: e.toString(), type: MessageType.error);
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
  }

  // ============================================================
  // FORM
  // ============================================================

  Widget _registerFormFields(Widget child) {
    return Form(key: _formKey, child: child);
  }

  // ============================================================
  // PAGE 1 — BASIC INFORMATION
  // ============================================================

  Widget page1() {
    return Column(
      children: [
        // -------------------- Full Name --------------------
        CustomTextField(
          model: CustomTextFieldModel(
            controller: _nameController,
            labelText: 'Full Name',
            hintText: 'Enter your full name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            state: _nameState,
            message: _nameMessage,
            onChanged: _validateName,
          ),
        ),

        30.h.verticalSpace,

        // -------------------- Email --------------------
        CustomTextField(
          model: CustomTextFieldModel(
            controller: _emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            state: _emailState,
            message: _emailMessage,
            onChanged: _validateEmail,
          ),
        ),

        30.h.verticalSpace,

        // -------------------- Next Button --------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppButton(
              text: _checkingEmail ? 'Checking...' : 'Next',
              height: AppDimensions.buttonHeight,
              borderRadius: AppRadius.large,
              width: AppDimensions.smallButtonWidth,
              isLoading: _isLoading || _checkingEmail,
              onPressed: _checkEmailAndContinue,
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // PAGE 2 — SECURITY
  // ============================================================

  Widget page2() {
    return Column(
      children: [
        // -------------------- New Password --------------------
        CustomTextField(
          model: CustomTextFieldModel(
            controller: _newPasswordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            state: _newPasswordState,
            message: _newPasswordMessage,
            onChanged: _validateNewPassword,
            obscureText: _newPasswordObscure,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _newPasswordObscure = !_newPasswordObscure;
                });
              },
              icon: Icon(
                _newPasswordObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
        ),

        30.h.verticalSpace,

        // -------------------- Confirm Password --------------------
        CustomTextField(
          model: CustomTextFieldModel(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            state: _confirmPasswordState,
            message: _confirmPasswordMessage,
            onChanged: _validateConfirmPassword,
            obscureText: _confirmPasswordObscure,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _confirmPasswordObscure = !_confirmPasswordObscure;
                });
              },
              icon: Icon(
                _confirmPasswordObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
        ),

        30.h.verticalSpace,

        // -------------------- Buttons --------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButton(
              text: 'Back',
              backgroundColor: AppColors.inactive,
              height: AppDimensions.buttonHeight,
              borderRadius: AppRadius.large,
              width: AppDimensions.smallButtonWidth,
              onPressed: _subCount,
            ),

            AppButton(
              text: 'Register',
              height: AppDimensions.buttonHeight,
              borderRadius: AppRadius.large,
              width: AppDimensions.smallButtonWidth,
              isLoading: _isLoading,
              onPressed: _register,
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // REGISTER HEADER
  // ============================================================

  Widget _registerHeaderFields() {
    return Column(
      children: [
        SizedBox(height: AppSpacing.xl.h),

        AuthHeader(
          title: registerTitle,
          subtitle: registerSubtitle,
          titleSubtitleSpacing: AppSpacing.sm.w,
        ),

        SizedBox(height: AppSpacing.xxl.h),
      ],
    );
  }

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> pages = {1: page1(), 2: page2()};

    return Scaffold(
      body: Stack(
        children: [
          const AuthBackground(),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 380;

                final horizontalPadding = isSmallScreen
                    ? AppSpacing.md.w
                    : AppSpacing.xxl.w;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: AppSpacing.md.h,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - AppSpacing.xl.h,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth > 600
                              ? 520.w
                              : constraints.maxWidth * 0.95,
                        ),
                        child: AuthCard(
                          headerFields: [_registerHeaderFields()],
                          formFields: [_registerFormFields(pages[_counter]!)],
                          dividerText: 'or',
                          footerText: 'Already have an account? Login now',
                          onFooterPressed: () {
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
