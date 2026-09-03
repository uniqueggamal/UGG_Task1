import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/providers/nav_provider.dart';
import 'package:internship_task/screens/base/base_screen.dart';
import 'package:internship_task/services/auth_service.dart';
import 'package:internship_task/shared/utils/app_styles.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/login_background.dart';
import '../../shared/widgets/login_card.dart';

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
  final email = TextEditingController(text: "NCCSIntern");
  final password = TextEditingController(text: "2026");

  bool hidePassword = true;
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();

    return Scaffold(
      body: Stack(
        children: [
          const LoginBackground(),

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
                              : constraints.maxWidth * 0.9,
                        ),
                        child: LoginCard(
                          email: email,
                          password: password,
                          hidePassword: hidePassword,
                          isLoading: isLoading,
                          errorMessage: errorMessage,
                          onTogglePassword: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          onLogin: () async {
                            setState(() {
                              isLoading = true;
                              errorMessage = null;
                            });

                            try {
                              final loginResponse = await AuthService().login(
                                email: email.text,
                                password: password.text,
                              );

                              if (loginResponse != null && loginResponse['token'] != null) {
                                final token = loginResponse['token'];
                                final userResponse = await AuthService().getUser(token);

                                if (userResponse != null) {
                                  print('Authenticated user: $userResponse');
                                  navProvider.login();

                                  if (mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const BaseScreen(),
                                      ),
                                    );
                                  }
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
                                errorMessage = 'Login failed. Please try again.';
                              });
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
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
