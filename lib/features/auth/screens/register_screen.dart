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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ============================================================
  // CONTROLLERS & FORM
  // ============================================================

  final _fName = TextEditingController();
  final _mName = TextEditingController();
  final _lName = TextEditingController();
  final _email = TextEditingController();
  final _nPassword = TextEditingController();
  final _cPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _authService = AuthService();

  // ============================================================
  // FIELD STATES
  // ============================================================

  FieldState _fNameState = FieldState.normal;
  String? _fNameMessage;

  FieldState _mNameState = FieldState.normal;
  String? _mNameMessage;

  FieldState _lNameState = FieldState.normal;
  String? _lNameMessage;

  FieldState _emailState = FieldState.normal;
  String? _emailMessage;

  FieldState _nPasswordState = FieldState.normal;
  String? _nPasswordMessage;

  FieldState _cPasswordState = FieldState.normal;
  String? _cPasswordMessage;

  // ============================================================
  // UI STATE
  // ============================================================

  bool _isLoading = false;
  bool _cObscure = true;
  bool _nObscure = true;

  static const registerTitle = "Register";
  static const registerSubtitle = "Your account Now!";

  // ============================================================
  // PAGE COUNTER
  // ============================================================

  int _counter = 1;

  void _addCount() {
    setState(() {
      _counter++;
    });
  }

  void _subCount() {
    setState(() {
      _counter--;
    });
  }

  // ============================================================
  // FIELD VALIDATION
  // ============================================================

  void _validateFName(String value) {
    final message = Validators.validateName(value);

    setState(() {
      _fNameMessage = message;
      _fNameState = message == null ? FieldState.normal : FieldState.error;
    });
  }

  void _validateMName(String value) {
    final message = Validators.validateMiddleName(value);

    setState(() {
      _mNameMessage = message;
      _mNameState = message == null ? FieldState.normal : FieldState.error;
    });
  }

  void _validateLName(String value) {
    final message = Validators.validateName(value);

    setState(() {
      _lNameMessage = message;
      _lNameState = message == null ? FieldState.normal : FieldState.error;
    });
  }

  void _validateEmail(String value) {
    final message = Validators.validateEmail(value);

    setState(() {
      _emailMessage = message;
      _emailState = message == null ? FieldState.normal : FieldState.error;
    });
  }

  void _validatePassword(String value) {
    final message = Validators.validatePassword(value);

    setState(() {
      _nPasswordMessage = message;
      _nPasswordState = message == null ? FieldState.normal : FieldState.error;
    });

    // Re-check confirm password if it already has a value.
    if (_cPassword.text.isNotEmpty) {
      _validateCPassword(_cPassword.text);
    }
  }

  void _validateCPassword(String value) {
    final message = Validators.validatePassword(value);
    final passwordsMatch = _cPassword.text == _nPassword.text;

    setState(() {
      if (message != null) {
        _cPasswordMessage = message;
        _cPasswordState = FieldState.error;
      } else if (!passwordsMatch) {
        _cPasswordMessage = 'Passwords do not match';
        _cPasswordState = FieldState.error;
      } else {
        _cPasswordMessage = null;
        _cPasswordState = FieldState.normal;
      }
    });
  }

  Future<void> register({required RegisterRequest model}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<AuthProvider>().registerUser(model);
      if (!mounted) return;

      AppMessage.show(
        context,
        message: "Registered Successfully",
        type: MessageType.success,
      );

      Navigator.pushNamed(context, AppRoutes.login);
    } catch (e) {
      if (!mounted) return;

      AppMessage.show(context, message: e.toString(), type: MessageType.error);
    } finally {
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
  // PAGE 1
  // ============================================================

  Widget page1() {
    return Column(
      children: [
        // -------------------- First Name --------------------
        CustomTextField(
          model: CustomTextFieldModel(
            controller: _fName,
            labelText: 'First Name',
            hintText: 'Enter first name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            state: _fNameState,
            message: _fNameMessage,
            onChanged: _validateFName,
          ),
        ),
        30.h.verticalSpace,

        // -------------------- Middle Name --------------------
        CustomTextField(
          model: CustomTextFieldModel(
            controller: _mName,
            labelText: 'Middle Name',
            hintText: 'Enter middle name (Optional)',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            state: _mNameState,
            message: _mNameMessage,
            onChanged: _validateMName,
          ),
        ),
        30.h.verticalSpace,
        // -------------------- Last Name --------------------
        CustomTextField(
          model: CustomTextFieldModel(
            controller: _lName,
            labelText: 'Last Name',
            hintText: 'Enter last name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            state: _lNameState,
            message: _lNameMessage,
            onChanged: _validateLName,
          ),
        ),
        30.h.verticalSpace,

        // -------------------- Next Button --------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppButton(
              text: 'Next',
              height: AppDimensions.buttonHeight,
              borderRadius: AppRadius.large,
              width: AppDimensions.smallButtonWidth,
              isLoading: _isLoading,
              onPressed: () {
                if (_fNameState == FieldState.normal &&
                    _mNameState == FieldState.normal &&
                    _lNameState == FieldState.normal &&
                    _fName.text.isNotEmpty &&
                    _lName.text.isNotEmpty) {
                  _addCount();
                  return;
                }

                setState(() {
                  if (_fName.text.isEmpty) {
                    _fNameState = FieldState.error;
                    _fNameMessage = 'First Name is required';
                  }

                  if (_lName.text.isEmpty) {
                    _lNameState = FieldState.error;
                    _lNameMessage = 'Last Name is required';
                  }
                });

                AppMessage.show(
                  context,
                  message: 'Please fill the fields correctly',
                  type: MessageType.error,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        // -------------------- Email --------------------
        CustomTextField(
          model: CustomTextFieldModel(
            controller: _email,
            labelText: 'Email',
            hintText: 'Enter email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            state: _emailState,
            message: _emailMessage,
            onChanged: _validateEmail,
          ),
        ),

        30.h.verticalSpace,

        // -------------------- Button --------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButton(
              text: 'Back',
              backgroundColor: AppColors.inactive,
              // foregroundColor: AppColors.textPrimary,
              height: AppDimensions.buttonHeight,
              borderRadius: AppRadius.large,
              width: AppDimensions.smallButtonWidth,
              onPressed: () {
                if (_emailMessage != null) {
                  _email.clear();
                  _emailState = FieldState.normal;
                  _emailMessage = null;
                }
                _subCount();
              },
            ),
            AppButton(
              text: 'Next',
              height: AppDimensions.buttonHeight,
              borderRadius: AppRadius.large,
              width: AppDimensions.smallButtonWidth,
              isLoading: _isLoading,
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  if (_emailMessage == null) {
                    final bool exists = await _authService.checkEmail(
                      _email.text,
                    );

                    if (!mounted) return;

                    if (exists) {
                      setState(() {
                        _emailState = FieldState.error;
                        _emailMessage = 'Email is already registered';
                      });
                      AppMessage.show(
                        context,
                        message: _emailMessage.toString(),
                        type: MessageType.warning,
                      );
                      return;
                    } else {
                      setState(() {
                        _emailState = FieldState.normal;
                      });
                    }

                    if (_emailState == FieldState.normal) {
                      _addCount();
                    }
                  }
                } catch (e) {
                  if (!mounted) return;

                  AppMessage.show(
                    context,
                    message: e.toString(),
                    type: MessageType.error,
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget page3() {
    return Column(
      children: [
        // -------------------- New Password --------------------
        CustomTextField(
          model: CustomTextFieldModel(
            controller: _nPassword,
            labelText: 'New Password',
            hintText: 'New Password',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            state: _nPasswordState,
            message: _nPasswordMessage,
            onChanged: _validatePassword,
            obscureText: _nObscure,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _nObscure = !_nObscure;
                });
              },
              icon: Icon(
                _nObscure
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
            controller: _cPassword,
            labelText: 'Confirm Password',
            hintText: 'Confirm Password',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            state: _cPasswordState,
            message: _cPasswordMessage,
            onChanged: _validateCPassword,
            obscureText: _cObscure,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _cObscure = !_cObscure;
                });
              },
              icon: Icon(
                _cObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
        ),
        30.h.verticalSpace,

        // -------------------- Next Button --------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButton(
              text: 'Back',
              backgroundColor: AppColors.inactive,
              // foregroundColor: AppColors.textPrimary,
              height: AppDimensions.buttonHeight,
              borderRadius: AppRadius.large,
              width: AppDimensions.smallButtonWidth,
              onPressed: () {
                if (_nPasswordMessage != null) {
                  _nPassword.clear();
                  _nPasswordState = FieldState.normal;
                  _nPasswordMessage = null;
                }
                if (_cPasswordMessage != null) {
                  _cPassword.clear();
                  _cPasswordState = FieldState.normal;
                  _cPasswordMessage = null;
                }

                _subCount();
              },
            ),
            AppButton(
              text: 'Register',
              height: AppDimensions.buttonHeight,
              borderRadius: AppRadius.large,
              width: AppDimensions.smallButtonWidth,
              isLoading: _isLoading,
              onPressed: () async {
                String name = _fName.text + _mName.text + _lName.text;
                final model = RegisterRequest(
                  name: name,
                  email: _email.text,
                  password: _nPassword.text,
                  passwordConfirmation: _cPassword.text,
                );
                register(model: model);
              },
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
    _fName.dispose();
    _mName.dispose();
    _lName.dispose();
    _email.dispose();
    _nPassword.dispose();
    _cPassword.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> pages = {1: page1(), 2: page2(), 3: page3()};
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
                          footerText: "Already have an account? Login now",
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
