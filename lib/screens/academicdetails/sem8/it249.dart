import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/utils/app_styles.dart';

class It249 extends StatefulWidget {
  const It249({super.key});

  @override
  State<It249> createState() => _It249State();
}

class _It249State extends State<It249> {
  // =========================
  // COURSE INFORMATION
  // =========================

  final String courseCode = "IT 249";

  final String courseTitle = "Business Intelligence";

  final String semester = "BIM 8th Semester";

  final String courseNature = "Information Technology and Computing";

  final String creditHours = "3 Credit Hours";

  final String lectureHours = "48 Lecture Hours";

  // =========================
  // COURSE OBJECTIVE
  // =========================

  final String objective =
      "This course aims to enable students to understand the role and "
      "importance of Business Intelligence (BI) in modern organizations. "
      "Students will learn key concepts and techniques in data warehousing, "
      "data mining, and data visualization. They will gain hands-on "
      "experience with popular BI tools and technologies while developing "
      "the skills needed to analyze and interpret data to support effective "
      "decision-making processes.";

  // =========================
  // COURSE DESCRIPTION
  // =========================

  final String description =
      "This course introduces the concepts, techniques, and tools used in "
      "Business Intelligence (BI) and data analytics. Students will learn "
      "how BI is used to transform data into meaningful insights for "
      "decision-making in organizations.";

  // =========================
  // UNIT 1
  // =========================

  final String unit1Title = "Introduction to Business Intelligence";

  final String unit1Hours = "5 Lecture Hours";

  final String unit1Topics =
      "Definition and Scope of Business Intelligence\n"
      "Importance of BI in Decision-Making\n"
      "Overview of BI Tools and Technologies";

  // =========================
  // UNIT 2
  // =========================

  final String unit2Title = "Data Warehousing";

  final String unit2Hours = "8 Lecture Hours";

  final String unit2Topics =
      "Introduction to Data Warehousing Concepts\n"
      "Data Warehouse Architecture\n"
      "ETL (Extract, Transform, Load) Processes\n"
      "Data Modeling for Business Intelligence";

  // =========================
  // UNIT 3
  // =========================

  final String unit3Title = "Data Mining";

  final String unit3Hours = "8 Lecture Hours";

  final String unit3Topics =
      "Introduction to Data Mining Concepts\n"
      "Data Preprocessing Techniques\n"
      "Classification and Clustering Algorithms\n"
      "Association Rule Mining";

  // =========================
  // UNIT 4
  // =========================

  final String unit4Title = "Data Visualization";

  final String unit4Hours = "7 Lecture Hours";

  final String unit4Topics =
      "Principles of Data Visualization\n"
      "Tools and Techniques for Data Visualization\n"
      "Dashboard Design and Best Practices";

  // =========================
  // UNIT 5
  // =========================

  final String unit5Title = "BI Tools and Technologies";

  final String unit5Hours = "12 Lecture Hours";

  final String unit5Topics =
      "Overview of Popular BI Tools such as Tableau and Power BI\n"
      "Hands-on Experience with BI Tools for Data Analysis and Reporting\n"
      "Introduction to OLAP (Online Analytical Processing)";

  // =========================
  // UNIT 6
  // =========================

  final String unit6Title = "BI Implementation";

  final String unit6Hours = "8 Lecture Hours";

  final String unit6Topics =
      "Best Practices for Implementing BI Solutions\n"
      "Challenges and Considerations in BI Implementation\n"
      "Case Studies of Successful BI Implementations";

  // =========================
  // LABORATORY WORK
  // =========================

  final String laboratoryWork =
      "The laboratory work involves learning to use various Business "
      "Intelligence (BI) tools and technologies. It also includes "
      "implementing data warehousing, data mining, and data visualization "
      "techniques.";

  // =========================
  // SUGGESTED READINGS
  // =========================

  final String suggestedReadings =
      "Sherman, R. (2014). Business Intelligence Guidebook: From Data "
      "Integration to Analytics. Morgan Kaufmann.\n\n"
      "Provost, F., & Fawcett, T. (2013). Data Science for Business: What "
      "You Need to Know about Data Mining and Data-Analytic Thinking. "
      "O'Reilly Media.\n\n"
      "Kimball, R., & Ross, M. (2013). The Data Warehouse Toolkit: The "
      "Definitive Guide to Dimensional Modeling. Wiley.";

  @override
  Widget build(BuildContext context) {
    var bodyPadding = EdgeInsets.fromLTRB(
      AppSpacing.md.w,
      AppSpacing.xs.h,
      AppSpacing.md.w,
      0,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course header
          Text(courseCode, style: AppTextStyles.headingSmall),

          AppSpacing.xs.h.verticalSpace,

          Text(courseTitle, style: AppTextStyles.headingLarge),

          AppSpacing.xxs.h.verticalSpace,

          // Course information
          Text(semester, style: AppTextStyles.labelLarge),

          AppSpacing.xxs.h.verticalSpace,

          Text(creditHours, style: AppTextStyles.labelSmall),

          AppSpacing.lg.h.verticalSpace,

          // Objective
          Text("Course Objective", style: AppTextStyles.headingSmall),

          Padding(
            padding: bodyPadding,
            child: Text(objective, style: AppTextStyles.bodyMedium),
          ),

          AppSpacing.md.h.verticalSpace,

          // Description
          Text("Course Description", style: AppTextStyles.headingSmall),

          Padding(
            padding: bodyPadding,
            child: Text(description, style: AppTextStyles.bodyMedium),
          ),

          AppSpacing.lg.h.verticalSpace,

          // Syllabus
          Text("Syllabus", style: AppTextStyles.headingSmall),

          AppSpacing.md.h.verticalSpace,

          // Unit 1
          Text(unit1Title, style: AppTextStyles.titleLarge),

          AppSpacing.xxs.h.verticalSpace,

          Text(unit1Hours, style: AppTextStyles.labelSmall),

          AppSpacing.xs.h.verticalSpace,

          Padding(
            padding: bodyPadding,
            child: Text(unit1Topics, style: AppTextStyles.bodyMedium),
          ),

          AppSpacing.md.h.verticalSpace,

          // Unit 2
          Text(unit2Title, style: AppTextStyles.titleLarge),

          AppSpacing.xxs.h.verticalSpace,

          Text(unit2Hours, style: AppTextStyles.labelSmall),

          AppSpacing.xs.h.verticalSpace,

          Padding(
            padding: bodyPadding,
            child: Text(unit2Topics, style: AppTextStyles.bodyMedium),
          ),

          AppSpacing.md.h.verticalSpace,

          // Unit 3
          Text(unit3Title, style: AppTextStyles.titleLarge),

          AppSpacing.xxs.h.verticalSpace,

          Text(unit3Hours, style: AppTextStyles.labelSmall),

          AppSpacing.xs.h.verticalSpace,

          Padding(
            padding: bodyPadding,
            child: Text(unit3Topics, style: AppTextStyles.bodyMedium),
          ),

          AppSpacing.md.h.verticalSpace,

          // Unit 4
          Text(unit4Title, style: AppTextStyles.titleLarge),

          AppSpacing.xxs.h.verticalSpace,

          Text(unit4Hours, style: AppTextStyles.labelSmall),

          AppSpacing.xs.h.verticalSpace,

          Padding(
            padding: bodyPadding,
            child: Text(unit4Topics, style: AppTextStyles.bodyMedium),
          ),

          AppSpacing.md.h.verticalSpace,

          // Unit 5
          Text(unit5Title, style: AppTextStyles.titleLarge),

          AppSpacing.xxs.h.verticalSpace,

          Text(unit5Hours, style: AppTextStyles.labelSmall),

          AppSpacing.xs.h.verticalSpace,

          Padding(
            padding: bodyPadding,
            child: Text(unit5Topics, style: AppTextStyles.bodyMedium),
          ),

          AppSpacing.md.h.verticalSpace,

          // Unit 6
          Text(unit6Title, style: AppTextStyles.titleLarge),

          AppSpacing.xxs.h.verticalSpace,

          Text(unit6Hours, style: AppTextStyles.labelSmall),

          AppSpacing.xs.h.verticalSpace,

          Padding(
            padding: bodyPadding,
            child: Text(unit6Topics, style: AppTextStyles.bodyMedium),
          ),

          AppSpacing.lg.h.verticalSpace,

          // Laboratory Work
          Text("Laboratory Work", style: AppTextStyles.headingSmall),

          AppSpacing.xs.h.verticalSpace,

          Padding(
            padding: bodyPadding,
            child: Text(laboratoryWork, style: AppTextStyles.bodyMedium),
          ),

          AppSpacing.lg.h.verticalSpace,

          // Suggested Readings
          Text("Suggested Readings", style: AppTextStyles.headingSmall),

          AppSpacing.xs.h.verticalSpace,

          Padding(
            padding: bodyPadding,
            child: Text(
              suggestedReadings,
              style: AppTextStyles.bodyMedium.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          300.verticalSpace,
        ],
      ),
    );
  }
}
