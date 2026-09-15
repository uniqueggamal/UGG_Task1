import 'package:flutter/material.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/features/academics/screens/academic_details_screen.dart';
import 'package:internship_task/features/home/screens/home_screen.dart';
import 'package:internship_task/features/auth/screens/login_screen.dart';
import 'package:internship_task/features/profile/screens/profile_screen.dart';
import 'package:internship_task/core/theme/app_styles.dart';
import 'package:internship_task/app/app_shell/base/widgets/bottom_nav_bar.dart';
import 'package:internship_task/app/app_shell/base/widgets/top_app_bar.dart';
import 'package:provider/provider.dart';

/// Base screen that handles the main navigation and authentication state
class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();
    return Scaffold(
      // extendBody: true,
      appBar: const TopAppBar(),
      bottomNavigationBar:
          (navProvider.currentIndex == 1 && navProvider.subIndex != "Subjects")
          ? null
          : const BottomNavBar(),

      backgroundColor: AppTextStyles.bgBoxColor,
      body: navProvider.currentIndex == 0
          ? const HomeScreen()
          : navProvider.currentIndex == 1
          ? const AcademicDetailsScreen()
          : navProvider.currentIndex == 2
          ? const ProfileScreen()
          : const Text("Default Page"),
    );
  }
}
