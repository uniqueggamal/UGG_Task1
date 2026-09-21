import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/user/models/full_profile_model.dart';
import 'package:internship_task/features/user/models/profile_model.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';
import 'package:internship_task/features/user/providers/user_provider.dart';
import 'package:internship_task/features/user/services/profile_service.dart';
import 'package:internship_task/features/user/widgets/profile/profile_header.dart';
import 'package:internship_task/features/user/widgets/profile/profile_info_card.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = UserProvider();
    final _auth = context.watch<AuthProvider>();
    return Padding(
      padding: EdgeInsets.fromLTRB(0, AppSpacing.xxl.h, 0, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.xxl.w,
          AppSpacing.xxl.h,
          AppSpacing.xxl.w,
          AppSpacing.xxl.h,
        ),
        child: FutureBuilder<FullProfileModel>(
          future: UserProvider().getFullProfile(_auth.token!),
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

            final academicQualification = profile.academicQualifications
                .map(
                  (item) => [
                    item.degree,
                    item.institution,
                    if (item.field != null) item.field!,
                  ].join(' • '),
                )
                .join('\n');
            final technicalSkills = profile.skills
                .map((skill) => skill.name)
                .join(' • ');
            final projects = profile.projects
                .map(
                  (project) => [
                    project.title,
                    if (project.description != null) project.description!,
                  ].join('\n'),
                )
                .join('\n\n');
            final coursework = profile.courseworks
                .map(
                  (item) => [
                    item.name,
                    if (item.description != null) item.description!,
                  ].join('\n'),
                )
                .join('\n\n');

            final interests = profile.interests
                .map((item) => item.name)
                .join(' • ');
            final achievements = profile.achievements
                .map(
                  (item) => [
                    item.title,
                    if (item.description != null) item.description!,
                    if (item.date != null) item.date!,
                  ].join('\n'),
                )
                .join('\n\n');

            return Column(
              children: [
                ProfileHeader(
                  name: profile.user.name,
                  title: profile.profile?.currentStatus ?? "",
                  imagePath: profile.profile?.profileImage ?? "",
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
                          content: profile.profile?.description ?? "",
                        ),

                        ProfileInfoCard(
                          icon: Icons.school_outlined,
                          title: "Academic Qualification",
                          content: academicQualification,
                        ),

                        ProfileInfoCard(
                          icon: Icons.code_outlined,
                          title: "Technical Skills",
                          content: technicalSkills,
                        ),

                        ProfileInfoCard(
                          icon: Icons.work_outline,
                          title: "Projects",
                          content: projects,
                        ),

                        ProfileInfoCard(
                          icon: Icons.workspace_premium_outlined,
                          title: "Achievements & Certifications",
                          content: achievements,
                        ),

                        ProfileInfoCard(
                          icon: Icons.menu_book_outlined,
                          title: "Relevant Coursework",
                          content: coursework,
                        ),

                        ProfileInfoCard(
                          icon: Icons.lightbulb_outline,
                          title: "Interests",
                          content: interests,
                          maxLines: 2,
                        ),

                        ProfileInfoCard(
                          icon: Icons.location_on_outlined,
                          title: "Location",
                          content: profile.profile?.location ?? "",
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
