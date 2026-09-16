import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/app/routes.dart';
import 'package:internship_task/core/storage/preference_storage.dart';
import 'package:internship_task/core/theme/app_dimensions.dart';
import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/utils/validators.dart';
import 'package:internship_task/core/widgets/app_button.dart';
import 'package:internship_task/core/widgets/app_message.dart';
import 'package:internship_task/core/widgets/cutom_textfield/custom_textfield.dart';
import 'package:internship_task/core/widgets/cutom_textfield/models/custom_textfield_model.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/app/app_shell/base/screens/base_screen.dart';
import 'package:internship_task/features/auth/services/auth_service.dart';
import 'package:internship_task/features/auth/widgets/form_items/auth_header.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/widgets/text_field.dart';
import 'package:provider/provider.dart';
import '../widgets/background_items/auth_background.dart';
import '../widgets/form_items/auth_card.dart';
import '../widgets/login_logo.dart';
import '../widgets/form_items/iconed_text_field.dart';

/// The main login screen responsible for:
/// - Screen-level state (email, password, loading, errors)
/// - Login flow coordination
/// - Navigation
/// - Connecting UI components together
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController(text: "unique@gmail.com");
  late var password = TextEditingController(text: "unique");
  final _formKey = GlobalKey<FormState>();
  FieldState emailState = FieldState.normal;
  String? emailMessage;

  FieldState passwordState = FieldState.normal;
  String? passwordMessage;

  bool hidePassword = true;
  bool _isLoading = false;

  PreferencesService save = PreferencesService();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void passwordDispose() {
    password = TextEditingController(text: "");
  }

  Future<void> _login(String email, String password) async {
    _isLoading = true;
    try {
      await context.read<AuthProvider>().login(
        email: email,
        password: password,
      );

      if (!context.mounted) return;

      AppMessage.show(
        context,
        message: 'Login successful',
        type: MessageType.success,
      );
      Navigator.pushNamed(context, AppRoutes.home);
    } on AuthException catch (e) {
      if (!context.mounted) return;
      AppMessage.show(context, message: e.message, type: MessageType.error);
    }
    _isLoading = false;
  }

  void _validateEmail(String value) {
    final message = Validators.validateEmail(value);

    setState(() {
      emailMessage = message;
      emailState = message == null ? FieldState.normal : FieldState.error;
    });
  }

  Widget loginFormFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          AppButton(
            text: 'Login',
            height: AppDimensions.buttonHeight,
            borderRadius: AppRadius.small,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _login(email.text, password.text);
              }
              passwordDispose();
            },
          ),
        ],
      ),
    );
  }

  Widget loginHeaderFields() {
    const loginTitle = "Welcome to";
    const loginSubtitle = "NCCS Internship";
    return Column(
      children: [
        Center(child: LoginLogo()),
        SizedBox(height: AppSpacing.xl.h),

        // Header
        AuthHeader(
          title: loginTitle,
          subtitle: loginSubtitle,
          titleSubtitleSpacing: AppSpacing.sm.w,
        ),

        SizedBox(height: AppSpacing.xxl.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();
    final authProvider = context.watch<AuthProvider>();

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
                          headerFields: [loginHeaderFields()],
                          formFields: [loginFormFields()],
                          dividerText: 'or',
                          footerText: "Don't have an account? Create one",
                          onFooterPressed: () {},
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
