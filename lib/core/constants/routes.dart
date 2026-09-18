import 'package:flutter/material.dart';
import 'package:internship_task/app/app_shell/base/screens/base_screen.dart';
import 'package:internship_task/features/auth/screens/login_screen.dart';
import 'package:internship_task/features/auth/screens/register_screen.dart';
import 'package:internship_task/features/user/screens/profile_screen.dart';
import 'package:internship_task/features/academics/screens/academic_details_screen.dart';

class AppRoutes {
  // Route names
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String academics = '/academics';

  // Route map
  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const BaseScreen(),
    profile: (context) => const ProfileScreen(),
    academics: (context) => const AcademicDetailsScreen(),
  };
}
