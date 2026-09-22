import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/features/auth/models/login_request.dart';
import 'package:internship_task/features/auth/models/register_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:internship_task/core/constants/routes.dart';

import 'package:internship_task/core/storage/preference_storage.dart';

import 'package:internship_task/core/theme/app_dimensions.dart';
import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/theme/app_spacing.dart';

import 'package:internship_task/core/utils/validators.dart';

import 'package:internship_task/core/widgets/app_button.dart';
import 'package:internship_task/core/widgets/app_message.dart';
import 'package:internship_task/core/widgets/cutom_textfield/custom_textfield.dart';
import 'package:internship_task/core/widgets/cutom_textfield/models/custom_textfield_model.dart';

import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/auth/services/auth_service.dart';
import 'package:internship_task/features/auth/widgets/form_items/auth_header.dart';

import '../widgets/background_items/auth_background.dart';
import '../widgets/form_items/auth_card.dart';
import '../widgets/login_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ============================================================
  // CONTROLLERS & FORM
  // ============================================================

  final email = TextEditingController(text: "unique11@gmail.com");
  late var password = TextEditingController(text: "worldstar11");

  final _formKey = GlobalKey<FormState>();

  // ============================================================
  // FIELD STATES
  // ============================================================

  FieldState emailState = FieldState.normal;
  String? emailMessage;

  FieldState passwordState = FieldState.normal;
  String? passwordMessage;

  // ============================================================
  // UI STATE
  // ============================================================

  bool hidePassword = true;
  bool _isLoading = false;

  // ============================================================
  // SERVICES
  // ============================================================

  PreferencesService save = PreferencesService();

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  // ============================================================
  // LOGIN
  // ============================================================

  Future<void> _login(LoginRequest model) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await context.read<AuthProvider>().login(model: model);

      if (!mounted) return;

      AppMessage.show(
        context,
        message: 'Login successful',
        type: MessageType.success,
      );

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } on AuthException catch (e) {
      if (!mounted) return;

      AppMessage.show(context, message: e.message, type: MessageType.error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ============================================================
  // FIELD VALIDATION
  // ============================================================

  void _validateEmail(String value) {
    final message = Validators.validateEmail(value);

    setState(() {
      emailMessage = message;
      emailState = message == null ? FieldState.normal : FieldState.error;
    });
  }

  void _validatePassword(String value) {
    final message = Validators.validatePassword(value);

    setState(() {
      passwordMessage = message;
      passwordState = message == null ? FieldState.normal : FieldState.error;
    });
  }

  // ============================================================
  // PASSWORD
  // ============================================================

  void passwordDispose() {
    password = TextEditingController(text: "");
  }

  // ============================================================
  // LOGIN FORM
  // ============================================================

  Widget loginFormFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // -------------------- Email --------------------
          CustomTextField(
            model: CustomTextFieldModel(
              controller: email,
              labelText: 'Email',
              hintText: 'Enter email',
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              enabled: !_isLoading,
              state: emailState,
              message: emailMessage,
              onChanged: _validateEmail,
            ),
          ),

          30.h.verticalSpace,

          // -------------------- Password --------------------
          CustomTextField(
            model: CustomTextFieldModel(
              inputDecoration: InputDecoration(),
              controller: password,
              labelText: 'Password',
              hintText: 'Enter password',
              prefixIcon: Icons.lock_outline,
              obscureText: hidePassword,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              enabled: !_isLoading,
              onChanged: _validatePassword,
              state: passwordState,
              message: passwordMessage,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(
                  hidePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
          ),

          30.h.verticalSpace,

          // -------------------- Login Button --------------------
          AppButton(
            text: 'Login',
            height: AppDimensions.buttonHeight,
            width: double.infinity,
            borderRadius: AppRadius.medium,
            isLoading: _isLoading,
            onPressed: () {
              final model = LoginRequest(
                email: email.text,
                password: password.text,
              );
              if (_formKey.currentState!.validate()) {
                if (emailState == FieldState.normal &&
                    passwordState == FieldState.normal) {
                  _login(model);
                } else {
                  AppMessage.show(
                    context,
                    message: "Please fill in correct details",
                    type: MessageType.error,
                  );
                  return;
                }
              }

              // passwordDispose();
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOGIN HEADER
  // ============================================================

  Widget loginHeaderFields() {
    const loginTitle = "Welcome to";
    const loginSubtitle = "NCCS Internship";

    return Column(
      children: [
        Center(child: LoginLogo()),

        SizedBox(height: AppSpacing.xl.h),

        AuthHeader(
          title: loginTitle,
          subtitle: loginSubtitle,
          titleSubtitleSpacing: AppSpacing.sm.w,
        ),

        SizedBox(height: AppSpacing.xxl.h),
      ],
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
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
                      minHeight: math.max(
                        0,
                        constraints.maxHeight - AppSpacing.xl.h,
                      ),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth > 600
                              ? 520.w
                              : constraints.maxWidth * 0.95,
                        ),
                        child: AuthCard(
                          headerFields: [loginHeaderFields()],
                          formFields: [loginFormFields()],
                          dividerText: 'or',
                          footerText: "Don't have an account? Create one",
                          onFooterPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
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
