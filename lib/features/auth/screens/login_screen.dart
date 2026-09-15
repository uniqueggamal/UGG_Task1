import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/app/app_shell/base/screens/base_screen.dart';
import 'package:internship_task/features/auth/services/auth_service.dart';
import 'package:internship_task/features/auth/widgets/form_items/auth_header.dart';
import 'package:internship_task/core/theme/app_styles.dart';
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
  final password = TextEditingController(text: "unique");

  bool hidePassword = true;
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Widget loginFormFields() {
    return Column(
      children: [
        LabeledTextField(
          label: 'Email',
          controller: email,
          icon: Icons.person_outline,
          hintText: 'Enter email',
          isLoading: isLoading,
          labelFieldSpacing: AppSpacing.sm.h,
        ),
        SizedBox(height: AppSpacing.lg.h),
        LabeledTextField(
          label: 'Password',
          controller: password,
          icon: Icons.lock_outline,
          hintText: 'Enter password',
          obscureText: hidePassword,
          isLoading: isLoading,
          labelFieldSpacing: AppSpacing.sm.h,
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
      ],
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
                          errorMessage: errorMessage,
                          buttonText: 'Login',
                          isLoading: isLoading,
                          onButtonPressed: () async {
                            setState(() {
                              isLoading = true;
                              errorMessage = null;
                            });

                            try {
                              final loginResponse = await AuthService().login(
                                email: email.text,
                                password: password.text,
                              );

                              if (loginResponse != null &&
                                  loginResponse['token'] != null) {
                                final token = loginResponse['token'];
                                final userResponse = await AuthService()
                                    .getUser(token);

                                if (userResponse != null) {
                                  print('Authenticated user: $userResponse');
                                  navProvider.login();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const BaseScreen(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    errorMessage = 'Failed to fetch user data';
                                  });
                                }
                              } else {
                                setState(() {
                                  errorMessage = 'Invalid credentials';
                                });
                              }
                            } catch (e) {
                              setState(() {
                                errorMessage =
                                    'Login failed. Please try again.';
                              });
                            } finally {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
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
