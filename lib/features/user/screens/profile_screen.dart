import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/utils/date_utils.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/user/handlers/profile_edit_handlers.dart';
import 'package:internship_task/features/user/models/full_profile_model.dart';
import 'package:internship_task/features/user/providers/user_provider.dart';
import 'package:internship_task/features/user/widgets/profile/profile_header.dart';
import 'package:internship_task/features/user/widgets/profile/profile_info_card.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<FullProfileModel>? _profileFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadProfile();
    });
  }

  String? get _token => context.read<AuthProvider>().token;

  void _loadProfile() {
    final token = _token;
    if (token == null || token.isEmpty) {
      setState(() => _profileFuture = null);
      return;
    }
    setState(() {
      _profileFuture = context.read<UserProvider>().getFullProfile(token);
    });
  }

  void _refreshProfile() {
    if (!mounted) return;
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (_profileFuture == null) {
      return const Center(child: Text('Not authenticated'));
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxl.w,
        AppSpacing.xxl.h,
        AppSpacing.xxl.w,
        AppSpacing.xxl.h,
      ),
      child: FutureBuilder<FullProfileModel>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSpacing.lg.r),
                child: Text(
                  'PROFILE ERROR\n\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No profile data'));
          }

          final profile = snapshot.data!;

          // Formatted card content
          final academic = profile.academicQualifications
              .map(
                (i) => [
                  i.degree,
                  i.institution,
                  if (i.field != null && i.field!.isNotEmpty) i.field!,
                  AppDateUtils.formatRange(i.startDate, i.endDate),
                ].where((v) => v.isNotEmpty).join(' • '),
              )
              .join('\n');

          final experiences = profile.experiences
              .map(
                (i) => [
                  i.position,
                  i.organization,
                  if (i.isCurrent)
                    'Current'
                  else
                    AppDateUtils.formatRange(i.startDate, i.endDate),
                ].where((v) => v.isNotEmpty).join(' • '),
              )
              .join('\n\n');

          final skills = profile.skills.map((s) => s.name).join(' • ');

          final projects = profile.projects
              .map(
                (p) => [
                  p.title,
                  if (p.description != null && p.description!.isNotEmpty)
                    p.description!,
                  if (p.link != null && p.link!.isNotEmpty) p.link!,
                ].join('\n'),
              )
              .join('\n\n');

          final achievements = profile.achievements
              .map(
                (a) => [
                  a.title,
                  if (a.description != null && a.description!.isNotEmpty)
                    a.description!,
                  if (a.date != null && a.date!.isNotEmpty)
                    AppDateUtils.toDisplay(a.date, includeDay: true),
                ].join('\n'),
              )
              .join('\n\n');

          final coursework = profile.courseworks
              .map(
                (c) => [
                  c.name,
                  if (c.description != null && c.description!.isNotEmpty)
                    c.description!,
                ].join('\n'),
              )
              .join('\n\n');

          final interests = profile.interests.map((i) => i.name).join(' • ');

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileHeader(
                        name: profile.user.name,
                        title: profile.profile?.currentStatus ?? '',
                        imagePath: profile.profile?.profileImage ?? '',
                        profile: profile.profile,
                        user: profile.user,
                      ),
                      10.verticalSpace,
                      AppSpacing.lg.h.verticalSpace,
                      AppSpacing.xxl.h.verticalSpace,

                      ProfileInfoCard(
                        icon: Icons.person_outline,
                        title: 'Description',
                        content: profile.profile?.description ?? '',
                        onEdit: () => ProfileEditHandlers.editDescription(
                          context,
                          profile,
                          _refreshProfile,
                        ),
                      ),
                      ProfileInfoCard(
                        icon: Icons.school_outlined,
                        title: 'Academic Qualification',
                        content: academic,
                        onEdit: () =>
                            ProfileEditHandlers.editAcademicQualifications(
                              context,
                              profile,
                              _refreshProfile,
                            ),
                      ),
                      ProfileInfoCard(
                        icon: Icons.work_history_outlined,
                        title: 'Experience',
                        content: experiences,
                        onEdit: () => ProfileEditHandlers.editExperiences(
                          context,
                          profile,
                          _refreshProfile,
                        ),
                      ),
                      ProfileInfoCard(
                        icon: Icons.code_outlined,
                        title: 'Technical Skills',
                        content: skills,
                        onEdit: () => ProfileEditHandlers.editTechnicalSkills(
                          context,
                          profile,
                          _refreshProfile,
                        ),
                      ),
                      ProfileInfoCard(
                        icon: Icons.work_outline,
                        title: 'Projects',
                        content: projects,
                        onEdit: () => ProfileEditHandlers.editProjects(
                          context,
                          profile,
                          _refreshProfile,
                        ),
                      ),
                      ProfileInfoCard(
                        icon: Icons.workspace_premium_outlined,
                        title: 'Achievements & Certifications',
                        content: achievements,
                        onEdit: () => ProfileEditHandlers.editAchievements(
                          context,
                          profile,
                          _refreshProfile,
                        ),
                      ),
                      ProfileInfoCard(
                        icon: Icons.menu_book_outlined,
                        title: 'Relevant Coursework',
                        content: coursework,
                        onEdit: () => ProfileEditHandlers.editCoursework(
                          context,
                          profile,
                          _refreshProfile,
                        ),
                      ),
                      ProfileInfoCard(
                        icon: Icons.lightbulb_outline,
                        title: 'Interests',
                        content: interests,
                        maxLines: 2,
                        onEdit: () => ProfileEditHandlers.editInterests(
                          context,
                          profile,
                          _refreshProfile,
                        ),
                      ),
                      ProfileInfoCard(
                        icon: Icons.location_on_outlined,
                        title: 'Location',
                        content: profile.profile?.location ?? '',
                        maxLines: 2,
                        onEdit: () => ProfileEditHandlers.editLocation(
                          context,
                          profile,
                          _refreshProfile,
                        ),
                      ),

                      SizedBox(height: AppSpacing.xxl.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
