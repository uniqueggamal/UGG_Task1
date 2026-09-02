import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/providers/navProvider.dart';
import 'package:internship_task/screens/basePage.dart';
import 'package:internship_task/utils/app_styles.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final username = TextEditingController(text: "NCCSIntern");
  final password = TextEditingController(text: "2026");

  bool hidePassword = true;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();

    return Scaffold(
      body: Stack(
        children: [
          const _LoginBackground(),

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
                        child: _LoginCard(
                          username: username,
                          password: password,
                          hidePassword: hidePassword,
                          onTogglePassword: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          onLogin: () {
                            if (username.text == 'NCCSIntern' &&
                                password.text == '2026') {
                              navProvider.login();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BasePage(),
                                ),
                              );
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

/// ------------------------------------------------------------
/// LOGIN CARD
/// ------------------------------------------------------------

class _LoginCard extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController password;
  final bool hidePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onLogin;

  const _LoginCard({
    required this.username,
    required this.password,
    required this.hidePassword,
    required this.onTogglePassword,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xxl.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 30,
            offset: Offset(0, 12),
            spreadRadius: 0,
            color: Color(0x22000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Logo
          const Center(child: _LoginLogo()),

          SizedBox(height: AppSpacing.xl.h),

          /// Heading
          Center(
            child: Text(
              'Welcome to',
              textAlign: TextAlign.center,
              style: AppTextStyles.headingLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          SizedBox(height: AppSpacing.xs.h),

          Center(
            child: Text(
              'NCCS Internship',
              textAlign: TextAlign.center,
              style: AppTextStyles.headingLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          SizedBox(height: AppSpacing.sm.h),

          /// Subtitle
          Center(
            child: Text(
              'Please login to continue',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.grey.shade600,
                letterSpacing: 0.8,
              ),
            ),
          ),

          SizedBox(height: AppSpacing.xxl.h),

          /// Username
          Text(
            'Username',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: AppSpacing.sm.h),

          _LoginTextField(
            controller: username,
            icon: Icons.person_outline,
            hintText: 'Enter username',
          ),

          SizedBox(height: AppSpacing.lg.h),

          /// Password
          Text(
            'Password',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: AppSpacing.sm.h),

          _LoginTextField(
            controller: password,
            icon: Icons.lock_outline,
            hintText: 'Enter password',
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: onTogglePassword,
              icon: Icon(
                hidePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),

          SizedBox(height: AppSpacing.xxl.h),

          /// Login button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: onLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                elevation: 5,
                shadowColor: AppColors.primary.withOpacity(0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
              ),
              child: Text(
                'Login',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          SizedBox(height: AppSpacing.xl.h),

          /// Divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
                child: Text(
                  'or',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),

          SizedBox(height: AppSpacing.md.h),

          /// Create account
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Don't have an account? Create one",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// TEXT FIELD
/// ------------------------------------------------------------

class _LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const _LoginTextField({
    required this.controller,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.primary),
        suffixIcon: suffixIcon,

        filled: true,
        fillColor: Colors.white.withOpacity(0.8),

        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg.w,
          vertical: AppSpacing.lg.h,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.1)),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.1)),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// LOGO
/// ------------------------------------------------------------

class _LoginLogo extends StatelessWidget {
  const _LoginLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.r,
      height: 64.r,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.school_rounded,
        size: 36,
        color: Colors.deepPurple,
      ),
    );
  }
}

/// ------------------------------------------------------------
/// BACKGROUND
/// ------------------------------------------------------------

class _LoginBackground extends StatelessWidget {
  const _LoginBackground();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        // Calculate circle sizes relative to screen dimensions
        final largeCircleSize = width * 0.65;
        final mediumCircleSize = width * 0.55;
        final smallCircleSize = width * 0.5;

        // Calculate ring sizes
        final largeRingSize = width * 0.32;
        final mediumRingSize = width * 0.35;

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF5F1FF), Color(0xFFFFFFFF), Color(0xFFECE5FF)],
            ),
          ),
          child: Stack(
            children: [
              /// Top-left large circle
              Positioned(
                top: -largeCircleSize * 0.38,
                left: -largeCircleSize * 0.35,
                child: _BackgroundCircle(size: largeCircleSize, opacity: 0.12),
              ),

              /// Top-right purple circle
              Positioned(
                top: -mediumCircleSize * 0.35,
                right: -mediumCircleSize * 0.3,
                child: _BackgroundCircle(size: mediumCircleSize, opacity: 0.18),
              ),

              /// Bottom-left circle
              Positioned(
                bottom: -mediumCircleSize * 0.39,
                left: -mediumCircleSize * 0.35,
                child: _BackgroundCircle(size: mediumCircleSize, opacity: 0.14),
              ),

              /// Bottom-right circle
              Positioned(
                bottom: -smallCircleSize * 0.32,
                right: -smallCircleSize * 0.36,
                child: _BackgroundCircle(size: smallCircleSize, opacity: 0.12),
              ),

              /// Top-right ring
              Positioned(
                top: height * 0.15,
                right: -largeRingSize * 0.25,
                child: _Ring(size: largeRingSize),
              ),

              /// Bottom-left ring
              Positioned(
                bottom: height * 0.14,
                left: -mediumRingSize * 0.32,
                child: _Ring(size: mediumRingSize),
              ),

              /// Decorative dots - positioned more responsively
              Positioned(
                top: height * 0.15,
                left: width * 0.1,
                child: const _DotGrid(),
              ),

              Positioned(
                bottom: height * 0.15,
                right: width * 0.1,
                child: const _DotGrid(),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// ------------------------------------------------------------
/// BACKGROUND OBJECTS
/// ------------------------------------------------------------

class _BackgroundCircle extends StatelessWidget {
  final double size;
  final double opacity;

  const _BackgroundCircle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withOpacity(opacity),
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  final double size;

  const _Ring({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15),
          width: 2,
        ),
      ),
    );
  }
}

class _DotGrid extends StatelessWidget {
  const _DotGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        4,
        (_) => Row(
          children: List.generate(
            4,
            (_) => Container(
              margin: const EdgeInsets.all(4),
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
