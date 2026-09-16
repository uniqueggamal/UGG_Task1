import 'package:flutter/material.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/core/providers/sub_provider.dart';
import 'package:internship_task/features/academics/widgets/hint_card.dart';
import 'package:internship_task/features/academics/widgets/subject_tile.dart';
import 'package:internship_task/features/academics/subjects/sem8/it248.dart';
import 'package:internship_task/features/academics/subjects/sem8/it249.dart';
import 'package:internship_task/features/academics/subjects/sem8/it250.dart';
import 'package:internship_task/features/academics/subjects/sem8/it277.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class AcademicDetailsScreen extends StatefulWidget {
  const AcademicDetailsScreen({super.key});

  @override
  State<AcademicDetailsScreen> createState() => _AcademicDetailsScreenState();
}

class _AcademicDetailsScreenState extends State<AcademicDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedSubject = context.watch<SubProvider>().subIndex;

    return selectedSubject == 'Subjects'
        ? buildSubjectList()
        : buildSubjectDetails(selectedSubject);
  }

  // ------------------------------------------------------------
  // SUBJECT LIST
  // ------------------------------------------------------------

  Widget buildSubjectList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // color: const Color(0xFFF9F9FB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.extraLarge2),
                  topRight: Radius.circular(AppRadius.extraLarge2),
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xxxl.w,
                AppSpacing.xxxl.h,
                AppSpacing.xxxl.w,
                AppSpacing.xxxl.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Coursework', style: AppTextStyles.headingMedium),

                  const SizedBox(height: 6),

                  Text(
                    'Check your current semester subjects',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 28),

                  const SubjectTile('IT 248'),
                  const SubjectTile('IT 249'),
                  const SubjectTile('IT 250'),
                  const SubjectTile('IT 277'),

                  const SizedBox(height: 24),

                  const HintCard(
                    message:
                        'Tap on any subject to view its module content, faculty information, and current schedule.',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // SUBJECT DETAILS
  // ------------------------------------------------------------

  Widget buildSubjectDetails(String selectedSubject) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.extraLarge2),
                  topRight: Radius.circular(AppRadius.extraLarge2),
                ),
              ),
              child: _buildSelectedSubject(selectedSubject),
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // SELECTED SUBJECT
  // ------------------------------------------------------------

  Widget _buildSelectedSubject(String selectedSubject) {
    switch (selectedSubject) {
      case 'IT 248':
        return const It248();

      case 'IT 249':
        return const It249();

      case 'IT 250':
        return const It250();

      case 'IT 277':
        return const It277();

      default:
        return const SizedBox.shrink();
    }
  }
}
