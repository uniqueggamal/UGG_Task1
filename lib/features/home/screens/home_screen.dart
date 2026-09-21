import 'package:flutter/material.dart';
import 'package:internship_task/features/home/widgets/horizontal_divider.dart';
import 'package:internship_task/features/home/widgets/identity_card_header.dart';
import 'package:internship_task/features/home/widgets/info_rows_section.dart';
import 'package:internship_task/features/home/widgets/name_section.dart';
import 'package:internship_task/features/home/widgets/profile_image.dart';
import 'package:internship_task/core/theme/app_spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

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
          child: Image.asset('assets/bottom_shape.png', fit: BoxFit.fitWidth),
        ),

        // Main content - takes all remaining space
        SizedBox.expand(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                SizedBox(height: AppSpacing.xxl.h),
                const ProfileImage(),
                SizedBox(height: AppSpacing.xxl.h),
                const NameSection(),
                SizedBox(height: AppSpacing.xxl.h),
                const HorizontalDivider(),
                const InfoRowsSection(),
                // Optional: add some bottom padding so content doesn't stick to the bottom bar
                SizedBox(height: AppSpacing.xxl.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
