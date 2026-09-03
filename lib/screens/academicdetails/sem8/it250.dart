// This is IT 250 Digital Economy

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/shared/utils/app_styles.dart';

class It250 extends StatefulWidget {
  const It250({super.key});

  @override
  State<It250> createState() => _It250State();
}

class _It250State extends State<It250> {
  // =========================
  // COURSE INFORMATION
  // =========================

  final String courseCode = "IT 250";

  final String courseTitle = "Digital Economy";

  final String semester = "BIM 8th Semester";

  final String courseNature = "Information Technology and Computing";

  final String creditHours = "3 Credit Hours";

  final String lectureHours = "48 Lecture Hours";

  // =========================
  // COURSE OBJECTIVE
  // =========================

  final String objective =
      "The course aims to enhance students' cognitive knowledge and "
      "practical skills in digital technologies in the field of economics "
      "and management.";

  // =========================
  // COURSE DESCRIPTION
  // =========================

  final String description =
      "This course deals with the introduction to digital economy, "
      "fundamentals of digital economy, digital markets, strategy and "
      "innovation, digital transformation, economics of information, "
      "and digitalization from a Nepalese perspective.";

  // =========================
  // UNIT 1
  // =========================

  final String unit1Title = "Introduction";

  final String unit1Hours = "8 Lecture Hours";

  final String unit1Topics =
      "Digital Economics: Concepts, Drivers, and Ecosystem\n"
      "K-Economy: Concepts and Drivers\n"
      "Differences Between Digital Economy and K-Economy\n"
      "The Fourth Industrial Revolution: Drivers, Opportunities, and Challenges\n"
      "Influence of Digital Economy: Sustainability, Privacy, Regulatory, and Strategies";

  // =========================
  // UNIT 2
  // =========================

  final String unit2Title = "Fundamentals of Digital Economy";

  final String unit2Hours = "7 Lecture Hours";

  final String unit2Topics =
      "Multi-Sided Platforms: Network Effects and Positive Feedback\n"
      "Lock-In and Switching Costs\n"
      "Formulation of Monopolies in the Digital Economy\n"
      "Digital Adoption Index and OECD Digital Adoption Government Index";

  // =========================
  // UNIT 3
  // =========================

  final String unit3Title = "Digital Markets, Strategy and Innovation";

  final String unit3Hours = "10 Lecture Hours";

  final String unit3Topics =
      "Competition, Cooperation, and Competition\n"
      "The Layered Internet Model\n"
      "Digital Innovation\n"
      "Digital Business Models\n"
      "Value Creation Models\n"
      "Modeling of Digital Markets";

  // =========================
  // UNIT 4
  // =========================

  final String unit4Title = "Digital Transformation";

  final String unit4Hours = "8 Lecture Hours";

  final String unit4Topics =
      "Digital Transformation: Concepts and Drivers\n"
      "Accelerating SDGs Through Digital Transformation\n"
      "Role of Technological Revolution in the World Economy\n"
      "Globalization and Economic Growth in the Digital Age\n"
      "Digital Currencies: Concepts and Types";

  // =========================
  // UNIT 5
  // =========================

  final String unit5Title = "Economics of Information";

  final String unit5Hours = "8 Lecture Hours";

  final String unit5Topics =
      "Asymmetric Information: Concepts and Determinants\n"
      "Asymmetric Information and Digitalization\n"
      "Online Search Engines\n"
      "Artificial Intelligence\n"
      "Strategy and the New Economics of Information\n"
      "Effects of Digitalization on Consumer Choice and Labor Markets\n"
      "Intellectual Property and Digitalization";

  // =========================
  // UNIT 6
  // =========================

  final String unit6Title = "Digitalization in Nepalese Perspective";

  final String unit6Hours = "7 Lecture Hours";

  final String unit6Topics =
      "E-Governance: Concepts, Process, and Structure\n"
      "E-Governance Practices in Nepal\n"
      "Digital Financial Inclusion in Nepalese Financial Markets\n"
      "Opportunities and Challenges for Digital Transformation in the Public Sector\n"
      "Digital Transformation and Economic Performance in Trade, Tourism, Agriculture, and SMEs";

  // =========================
  // SUGGESTED READINGS
  // =========================

  final String suggestedReadings =
      "Øverby, H., & Audestad, J. A. (2021). Introduction to Digital "
      "Economics: Foundations, Business Models and Case Studies (2nd ed.). "
      "Springer.\n\n"
      "Maheshwari, A. (2019). Digital Transformation: Building Intelligent "
      "Enterprises. Wiley.\n\n"
      "Adhikari, G. M. (n.d.). Digital Economics (Recent ed.). Kathmandu.";

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
