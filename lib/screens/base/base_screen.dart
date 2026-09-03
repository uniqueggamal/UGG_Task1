import 'package:flutter/material.dart';
import 'package:internship_task/providers/nav_provider.dart';
import 'package:internship_task/screens/academic_details/academic_details_screen.dart';
import 'package:internship_task/screens/home/home_screen.dart';
import 'package:internship_task/screens/login/login_screen.dart';
import 'package:internship_task/screens/profile/profile_screen.dart';
import 'package:internship_task/shared/utils/app_styles.dart';
import 'package:internship_task/shared/widgets/bottom_nav_bar.dart';
import 'package:internship_task/shared/widgets/top_app_bar.dart';
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
    return navProvider.authState
        ? Scaffold(
            // extendBody: true,
            bottomNavigationBar:
                (navProvider.currentIndex == 1 &&
                    navProvider.subIndex != "Subjects")
                ? null
                : const BottomNavBar(),

            backgroundColor: AppTextStyles.bgBoxColor,
            body: Column(
              children: [
                const TopAppBar(),
                Expanded(
                  child: navProvider.currentIndex == 0
                      ? const HomeScreen()
                      : navProvider.currentIndex == 1
                      ? const AcademicDetailsScreen()
                      : navProvider.currentIndex == 2
                      ? const ProfileScreen()
                      : const Text("Default Page"),
                ),
              ],
            ),
          )
        : const LoginScreen();
  }
}
