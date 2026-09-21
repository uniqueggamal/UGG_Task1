import 'package:flutter/material.dart';
import 'package:internship_task/app/app_shell/base/widgets/bottom_nav_bar.dart';
import 'package:internship_task/app/app_shell/base/widgets/top_app_bar.dart';
import 'package:internship_task/core/constants/routes.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/core/providers/sub_provider.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/features/academics/screens/academic_details_screen.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/home/screens/home_screen.dart';
import 'package:internship_task/features/user/screens/initialize_screen.dart';
import 'package:internship_task/features/user/screens/profile_screen.dart';
import 'package:internship_task/features/user/services/user_service.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool _needsInitialization = false;
  bool _checkingProfile = true;

  @override
  void initState() {
    super.initState();
    _checkProfile();
  }

  Future<void> _checkProfile() async {
    final authProvider = context.read<AuthProvider>();
    final subProvider = context.read<SubProvider>();

    if (!authProvider.authState || authProvider.token == null) {
      if (!mounted) return;

      setState(() {
        _checkingProfile = false;
      });

      return;
    }

    try {
      final userService = UserService();

      final userData = await userService.getFullProfile(authProvider.token!);

      print('========== PROFILE CHECK ==========');
      print('Full user data: $userData');
      print('Data: ${userData.profile}');
      print('===================================');

      final profile = userData.profile;

      final needsInitialization = profile == null;
      subProvider.subIndex = "Set up Profile";

      if (!mounted) return;

      setState(() {
        _needsInitialization = needsInitialization;
        _checkingProfile = false;
      });

      if (needsInitialization) {
        print('Profile is null → redirecting to initialization');
      } else {
        print('Profile exists → continuing to BaseScreen');
      }
    } catch (e) {
      print('Profile check failed: $e');

      if (!mounted) return;

      setState(() {
        _checkingProfile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();
    final subProvider = context.watch<SubProvider>();

    if (_checkingProfile) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (subProvider.subIndex != "Set up Profile") {
      _needsInitialization = false;
    }
    return Scaffold(
      appBar: TopAppBar(needsinitialize: _needsInitialization),
      bottomNavigationBar:
          (navProvider.currentIndex == 1 &&
                  subProvider.subIndex != "Subjects") ||
              (_needsInitialization)
          ? null
          : const BottomNavBar(),
      backgroundColor: AppColors.surfaceMuted,
      body: _needsInitialization
          ? InitializeScreen()
          : navProvider.currentIndex == 0
          ? const HomeScreen()
          : navProvider.currentIndex == 1
          ? const AcademicDetailsScreen()
          : navProvider.currentIndex == 2
          ? const ProfileScreen()
          : const Text("Default Page"),
    );
  }
}
