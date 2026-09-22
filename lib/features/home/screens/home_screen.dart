import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/utils/date_utils.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/home/widgets/horizontal_divider.dart';
import 'package:internship_task/features/home/widgets/info_rows_section.dart';
import 'package:internship_task/features/home/widgets/name_section.dart';
import 'package:internship_task/features/home/widgets/profile_image.dart';
import 'package:internship_task/features/user/models/full_profile_model.dart';
import 'package:internship_task/features/user/services/user_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService _userService = UserService();

  Future<FullProfileModel>? _profileFuture;

  @override
  void initState() {
    super.initState();

    final token = context.read<AuthProvider>().token;
    if (token != null && token.isNotEmpty) {
      _profileFuture = _userService.getFullProfile(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();

    if (auth.token == null || auth.token!.isEmpty) {
      return const Center(child: Text('Authentication token not found.'));
    }

    if (_profileFuture == null) {
      return const Center(child: Text('Authentication token not found.'));
    }

    return FutureBuilder<FullProfileModel>(
      future: _profileFuture,
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (snapshot.hasError) {
          debugPrint('========================================');
          debugPrint('HOME PROFILE ERROR');
          debugPrint('ERROR TYPE: ${snapshot.error.runtimeType}');
          debugPrint('ERROR: ${snapshot.error}');
          debugPrint('STACK TRACE:');
          debugPrint('${snapshot.stackTrace}');
          debugPrint('========================================');

          return const Center(child: Text('Failed to load profile.'));
        }

        // No data
        if (!snapshot.hasData) {
          return const Center(child: Text('No profile data available.'));
        }

        final fullProfile = snapshot.data!;
        final user = fullProfile.user;
        final profile = fullProfile.profile;

        return Stack(
          children: [
            // Top decoration
            Positioned(
              top: -60,
              left: 0,
              right: 0,
              child: Image.asset('assets/top_shape.png', fit: BoxFit.fitWidth),
            ),

            // Bottom decoration
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/bottom_shape.png',
                fit: BoxFit.fitWidth,
              ),
            ),

            // Main content
            SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    SizedBox(height: AppSpacing.xxl.h),

                    // Profile picture
                    ProfileImage(profile: profile),

                    SizedBox(height: AppSpacing.xxl.h),

                    // Name
                    NameSection(user: user, profile: profile),

                    SizedBox(height: AppSpacing.xxl.h),

                    // Divider
                    const HorizontalDivider(),

                    // Information
                    InfoRowsSection(
                      values: [
                        (
                          label: 'DOB',
                          value: AppDateUtils.toDisplay(
                            profile?.dateOfBirth,
                            includeDay: true,
                          ),
                        ),
                        (label: 'Phone', value: profile?.phone),
                        (label: 'Email', value: user.email),
                        (label: 'Location', value: profile?.location),
                      ],
                    ),

                    SizedBox(height: AppSpacing.xxl.h),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}