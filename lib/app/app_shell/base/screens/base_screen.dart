import 'package:flutter/material.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/providers/sub_provider.dart';
import 'package:internship_task/features/academics/screens/academic_details_screen.dart';
import 'package:internship_task/features/home/screens/home_screen.dart';
import 'package:internship_task/features/user/screens/profile_screen.dart';
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
    final subProvider = context.watch<SubProvider>();
    return Scaffold(
      // extendBody: true,
      appBar: const TopAppBar(),
      bottomNavigationBar:
          (navProvider.currentIndex == 1 && subProvider.subIndex != "Subjects")
          ? null
          : const BottomNavBar(),

      backgroundColor: AppColors.surfaceMuted,
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
