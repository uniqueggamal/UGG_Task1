import 'package:flutter/material.dart';
import 'package:internship_task/providers/navProvider.dart';
import 'package:internship_task/screens/academicDetailsPage.dart';
import 'package:internship_task/screens/homePage.dart';
import 'package:internship_task/screens/profilePage.dart';
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
    return Scaffold(
      appBar: TopAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: navProvider.currentIndex == 0
          ? Homepage()
          : navProvider.currentIndex == 1
          ? AcademicDetailsPage()
          : navProvider.currentIndex == 2
          ? ProfilePage()
          : Text("Default Page"),
    );
  }
}
