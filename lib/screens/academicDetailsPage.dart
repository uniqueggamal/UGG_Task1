import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/providers/navProvider.dart';
import 'package:internship_task/screens/academicdetails/sem8/it248.dart';
import 'package:internship_task/screens/academicdetails/sem8/it249.dart';
import 'package:internship_task/screens/academicdetails/sem8/it250.dart';
import 'package:internship_task/screens/academicdetails/sem8/it277.dart';
import 'package:internship_task/utils/app_styles.dart';
import 'package:provider/provider.dart';

class AcademicDetailsPage extends StatefulWidget {
  const AcademicDetailsPage({super.key});

  @override
  State<AcademicDetailsPage> createState() => _AcademicDetailsPageState();
}

class _AcademicDetailsPageState extends State<AcademicDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final selectedSubject = context.watch<NavProvider>().subIndex;

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
                color: const Color(0xFFF9F9FB),
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

                  buildSubjectTile('IT 248'),
                  buildSubjectTile('IT 249'),
                  buildSubjectTile('IT 250'),
                  buildSubjectTile('IT 277'),

                  const SizedBox(height: 24),

                  _buildHintCard(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // SUBJECT TILE
  // ------------------------------------------------------------

  Widget buildSubjectTile(String subject) {
    final navProvider = context.read<NavProvider>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: AppColors.surface,
        elevation: 0,
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.large),
          onTap: () => navProvider.subjectIndex(subject),
          child: Container(
            constraints: const BoxConstraints(minHeight: 72),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.large),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Subject icon
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCF1FF),
                    borderRadius: BorderRadius.circular(AppRadius.small),
                  ),
                  child: const Icon(
                    Icons.library_books,
                    color: Colors.black54,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 16),

                // Subject information
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject,
                        style: AppTextStyles.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Subject Details',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Arrow
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF6B7280),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // HINT CARD
  // ------------------------------------------------------------

  Widget _buildHintCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8FF),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: const Color(0xFFF2DCF7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: Color(0xFFFFB300),
            size: 20,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              'Tap on any subject to view its module content, faculty information, and current schedule.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: const Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
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
