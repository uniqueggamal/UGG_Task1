import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/shared/utils/app_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String description =
      "I am an enthusiastic and motivated Information Management student "
      "with a strong academic background in information technology, business, "
      "and management. I have developed foundational knowledge in software "
      "development, database management, data analysis, and information systems "
      "through academic projects and practical coursework. I am eager to apply "
      "my academic knowledge in a professional environment, learn from "
      "experienced professionals, and contribute positively to team projects "
      "while continuously developing my technical and professional skills.";

  final String academicQualification =
      "Bachelor of Information Management (BIM)\n"
      "National College of Computer Studies (NCCS)\n"
      "Tribhuvan University\n"
      "8th Semester";

  final String technicalSkills =
      "Flutter, Dart, Firebase, SQL, Python, Git, GitHub, "
      "UI Design, Responsive Design, State Management.";

  final String projects =
      "Plant Disease Detection App\n"
      "A Flutter-based mobile application that uses a machine learning "
      "model to identify plant diseases from leaf images.\n\n"
      "Internship Task App\n"
      "A responsive Flutter application developed to demonstrate UI design, "
      "responsive layouts, navigation, and state management.";

  final String achievements =
      "Flutter and Dart related certifications\n"
      "Software development workshops and training\n"
      "Academic projects and practical coursework\n"
      "Technology-related seminars and events";

  final String relevantCoursework =
      "Software Engineering, Database Management, Business Information "
      "Systems, Cloud Computing, Business Intelligence, IT Entrepreneurship, "
      "Digital Economy, and Information Technology Management.";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, AppSpacing.xxl.h, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTextStyles.bgBoxColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.extraLarge2),
            topRight: Radius.circular(AppRadius.extraLarge2),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.xxl.w,
            AppSpacing.xxl.h,
            AppSpacing.xxl.w,
            AppSpacing.xxl.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.lg.h.verticalSpace,

                // Profile Header
                Row(
                  children: [
                    AppSpacing.sm.w.horizontalSpace,

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 80,
                          minWidth: 80,
                          maxHeight: 300,
                          maxWidth: 300,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/pp.jpg',
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    AppSpacing.sm.w.horizontalSpace,

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unique G. Gamal',
                          style: AppTextStyles.headingLarge,
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        Text(
                          'BIM student | 8th Semester',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),

                AppSpacing.xxl.h.verticalSpace,

                // Description
                ProfileInfoCard(
                  icon: Icons.person_outline,
                  title: "Description",
                  content: description,
                ),

                // Academic Qualification
                ProfileInfoCard(
                  icon: Icons.school_outlined,
                  title: "Academic Qualification",
                  content: academicQualification,
                ),

                // Technical Skills
                ProfileInfoCard(
                  icon: Icons.code_outlined,
                  title: "Technical Skills",
                  content: technicalSkills,
                ),

                // Projects
                ProfileInfoCard(
                  icon: Icons.work_outline,
                  title: "Projects",
                  content: projects,
                ),

                // Achievements & Certifications
                ProfileInfoCard(
                  icon: Icons.workspace_premium_outlined,
                  title: "Achievements & Certifications",
                  content: achievements,
                ),

                // Relevant Coursework
                ProfileInfoCard(
                  icon: Icons.menu_book_outlined,
                  title: "Relevant Coursework",
                  content: relevantCoursework,
                ),

                // Interests
                ProfileInfoCard(
                  icon: Icons.lightbulb_outline,
                  title: "Interests",
                  content: "Flutter, UI design, and cloud computing",
                  maxLines: 2,
                ),

                // Location
                ProfileInfoCard(
                  icon: Icons.location_on_outlined,
                  title: "Location",
                  content: "Kathmandu, Nepal",
                  maxLines: 2,
                ),
                300.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable profile information card.
class ProfileInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;
  final int maxLines;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.maxLines = 3,
  });

  @override
  State<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSpacing.xxl.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(widget.icon, size: 20.r),

              AppSpacing.sm.w.horizontalSpace,

              Text(widget.title, style: AppTextStyles.bodyLarge),
            ],
          ),

          AppSpacing.md.h.verticalSpace,

          Text(
            widget.content,
            maxLines: isExpanded ? null : widget.maxLines,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium,
          ),

          AppSpacing.xs.h.verticalSpace,

          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? "Show less" : "Show more",
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
