import 'package:flutter/material.dart';
import 'package:internship_task/app/app_shell/base/widgets/bottom_nav_bar.dart';
import 'package:internship_task/app/app_shell/base/widgets/top_app_bar.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/core/providers/sub_provider.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/features/academics/screens/academic_details_screen.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/home/screens/home_screen.dart';
import 'package:internship_task/features/user/screens/profile_setup.dart';
import 'package:internship_task/features/user/screens/profile_screen.dart';
import 'package:internship_task/features/user/services/user_service.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool _checkingProfile = true;

  @override
  void initState() {
    super.initState();
    _checkProfile();
  }

  Future<void> _checkProfile() async {
    final authProvider = context.read<AuthProvider>();

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

      debugPrint('========== PROFILE CHECK ==========');
      debugPrint('User: ${userData.user.name}');
      debugPrint('Profile exists: ${userData.profile != null}');
      debugPrint('===================================');

      final needsInitialization = userData.profile == null;

      if (!mounted) return;

      setState(() {
        _checkingProfile = false;
      });

      if (needsInitialization) {
        debugPrint('Profile is null → opening InitializeScreen');

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileSetup()),
        );

        debugPrint('Returned from InitializeScreen');
      } else {
        debugPrint('Profile exists → continuing to BaseScreen');
      }
    } catch (e, stackTrace) {
      debugPrint('Profile check failed: $e');
      debugPrint('Stack trace: $stackTrace');

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

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (navProvider.currentIndex == 1 && subProvider.backState) {
          subProvider.defaultSubjectIndex();
        }
      },
      child: Scaffold(
        appBar: const TopAppBar(),

        bottomNavigationBar:
            navProvider.currentIndex == 1 && subProvider.subIndex != 'Subjects'
            ? null
            : const BottomNavBar(),

        backgroundColor: AppColors.surfaceMuted,

        body: navProvider.currentIndex == 0
            ? const HomeScreen()
            : navProvider.currentIndex == 1
            ? const AcademicDetailsScreen()
            : navProvider.currentIndex == 2
            ? const ProfileScreen()
            : const Text('Default Page'),
      ),
    );
  }
}
