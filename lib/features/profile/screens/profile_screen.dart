import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/features/profile/models/profile_model.dart';
import 'package:internship_task/features/profile/services/profile_service.dart';
import 'package:internship_task/features/profile/widgets/profile_header.dart';
import 'package:internship_task/features/profile/widgets/profile_info_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, AppSpacing.xxl.h, 0, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.xxl.w,
          AppSpacing.xxl.h,
          AppSpacing.xxl.w,
          AppSpacing.xxl.h,
        ),
        child: FutureBuilder<ProfileModel>(
          future: ProfileService().getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error loading profile'));
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No profile data'));
            }

            final profile = snapshot.data!;

            return Column(
              children: [
                ProfileHeader(
                  name: profile.name,
                  title: profile.title,
                  imagePath: profile.imagePath,
                ),
                10.verticalSpace,

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.lg.h.verticalSpace,

                        AppSpacing.xxl.h.verticalSpace,

                        ProfileInfoCard(
                          icon: Icons.person_outline,
                          title: "Description",
                          content: profile.description,
                        ),

                        ProfileInfoCard(
                          icon: Icons.school_outlined,
                          title: "Academic Qualification",
                          content: profile.academicQualification,
                        ),

                        ProfileInfoCard(
                          icon: Icons.code_outlined,
                          title: "Technical Skills",
                          content: profile.technicalSkills,
                        ),

                        ProfileInfoCard(
                          icon: Icons.work_outline,
                          title: "Projects",
                          content: profile.projects,
                        ),

                        ProfileInfoCard(
                          icon: Icons.workspace_premium_outlined,
                          title: "Achievements & Certifications",
                          content: profile.achievements,
                        ),

                        ProfileInfoCard(
                          icon: Icons.menu_book_outlined,
                          title: "Relevant Coursework",
                          content: profile.relevantCoursework,
                        ),

                        ProfileInfoCard(
                          icon: Icons.lightbulb_outline,
                          title: "Interests",
                          content: profile.interests,
                          maxLines: 2,
                        ),

                        ProfileInfoCard(
                          icon: Icons.location_on_outlined,
                          title: "Location",
                          content: profile.location,
                          maxLines: 2,
                        ),
                        300.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
