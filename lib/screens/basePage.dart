import 'package:flutter/material.dart';
import 'package:internship_task/providers/navProvider.dart';
import 'package:internship_task/screens/academicDetailsPage.dart';
import 'package:internship_task/screens/homePage.dart';
import 'package:internship_task/screens/loginPage.dart';
import 'package:internship_task/screens/profilePage.dart';
import 'package:internship_task/utils/app_styles.dart';
import 'package:internship_task/widgets/bottomNavBar.dart';
import 'package:internship_task/widgets/topAppbar.dart';
import 'package:provider/provider.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();
    return navProvider.authState
        ? Scaffold(
            extendBody: true,
            bottomNavigationBar:
                (navProvider.currentIndex == 1 &&
                    navProvider.subIndex != "Subjects")
                ? null
                : BottomNavBar(),

            backgroundColor: AppTextStyles.bgBoxColor,
            body: Column(
              children: [
                TopAppBar(),
                Expanded(
                  child: navProvider.currentIndex == 0
                      ? Homepage()
                      : navProvider.currentIndex == 1
                      ? AcademicDetailsPage()
                      : navProvider.currentIndex == 2
                      ? ProfilePage()
                      : Text("Default Page"),
                ),
              ],
            ),
          )
        : Loginscreen();
  }
}
