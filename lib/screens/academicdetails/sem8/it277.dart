// This is IT 277 Cloud Computing

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/utils/app_styles.dart';

class It277 extends StatefulWidget {
  const It277({super.key});

  @override
  State<It277> createState() => _It277State();
}

class _It277State extends State<It277> {
  // =========================
  // COURSE INFORMATION
  // =========================

  final String courseCode = "IT 277";

  final String courseTitle = "Cloud Computing";

  final String semester = "BIM 8th Semester";

  final String courseNature = "Elective";

  final String creditHours = "3 Credit Hours";

  final String lectureHours = "48 Lecture Hours";

  // =========================
  // COURSE OBJECTIVE
  // =========================

  final String objective =
      "The main objectives of this course are to provide theoretical as "
      "well as practical knowledge of cloud computing, including designing, "
      "implementing, and managing cloud computing.";

  // =========================
  // COURSE DESCRIPTION
  // =========================

  final String description =
      "This course provides both theoretical and practical knowledge of "
      "cloud computing. It covers key concepts and practices related to "
      "designing, implementing, and managing cloud-based systems. Students "
      "will learn about various cloud service models, deployment strategies, "
      "and management techniques essential for building efficient and "
      "scalable cloud solutions.";

  // =========================
  // UNIT 1
  // =========================

  final String unit1Title = "Introduction to Cloud Computing";

  final String unit1Hours = "5 Lecture Hours";

  final String unit1Topics =
      "Evolution of Cloud Computing\n"
      "Characteristics of Cloud Computing\n"
      "Types of Cloud and Cloud Services\n"
      "Benefits and Challenges of Cloud Computing\n"
      "Applications of Cloud Computing\n"
      "Cloud Storage\n"
      "Cloud Services Requirements\n"
      "Cloud and Dynamic Infrastructure\n"
      "Cloud Adoption";

  // =========================
  // UNIT 2
  // =========================

  final String unit2Title = "Cloud Computing Architecture";

  final String unit2Hours = "5 Lecture Hours";

  final String unit2Topics =
      "Platform as a Service (PaaS)\n"
      "Software as a Service (SaaS)\n"
      "Infrastructure as a Service (IaaS)\n"
      "Public Clouds\n"
      "Private Clouds\n"
      "Community Clouds\n"
      "Hybrid Clouds\n"
      "Cloud Design and Implementation Using SOA\n"
      "Security, Trust, and Privacy";

  // =========================
  // UNIT 3
  // =========================

  final String unit3Title = "Cloud Applications";

  final String unit3Hours = "5 Lecture Hours";

  final String unit3Topics =
      "Migrating to the Cloud\n"
      "Software Licenses\n"
      "Cloud Cost Model\n"
      "Service Levels for Cloud Applications\n"
      "Security of Cloud Applications\n"
      "Web Applications Design";

  // =========================
  // UNIT 4
  // =========================

  final String unit4Title = "Cloud Virtualization Technology";

  final String unit4Hours = "8 Lecture Hours";

  final String unit4Topics =
      "Introduction to Virtualization\n"
      "Different Types of Virtualization\n"
      "Implementation Levels of Virtualization Structures\n"
      "Benefits of Virtualization\n"
      "Server Virtualization\n"
      "Virtualization Software\n"
      "Types of Hypervisor\n"
      "Load Balancing\n"
      "Infrastructure Requirements for Virtualization";

  // =========================
  // UNIT 5
  // =========================

  final String unit5Title = "MapReduce and Applications";

  final String unit5Hours = "7 Lecture Hours";

  final String unit5Topics =
      "Parallel Computing\n"
      "MapReduce Model\n"
      "MapReduce Applications\n"
      "Parallel Efficiency of MapReduce\n"
      "Enterprise Batch Processing Using MapReduce";

  // =========================
  // UNIT 6
  // =========================

  final String unit6Title = "Cloud Security";

  final String unit6Hours = "6 Lecture Hours";

  final String unit6Topics =
      "Cloud Security Issues, Challenges, and Risks\n"
      "Software-as-a-Service Security\n"
      "Security Monitoring\n"
      "Security Architecture Design\n"
      "Data and Application Security\n"
      "Virtual Machine Security\n"
      "Legal Issues and Aspects\n"
      "Multi-Tenancy Issues";

  // =========================
  // UNIT 7
  // =========================

  final String unit7Title = "Cloud Platforms and Applications";

  final String unit7Hours = "12 Lecture Hours";

  final String unit7Topics =
      "Web Services\n"
      "AppEngine\n"
      "Azure Platform\n"
      "Aneka\n"
      "Open Challenges\n"
      "Scientific Applications\n"
      "Business and Consumer Applications";

  // =========================
  // LABORATORY WORK
  // =========================

  final String laboratoryWork =
      "The practical work should cover all features of cloud computing.";

  // =========================
  // SUGGESTED READINGS
  // =========================

  final String suggestedReadings =
      "Saurabh, K. (2017). Cloud Computing (4th ed.). Wiley.\n\n"
      "Buyya, R., Vecchiola, C., & Selvi, S. T. (2013). Mastering Cloud "
      "Computing: Foundations and Applications Programming. Morgan Kaufmann.\n\n"
      "Linthicum, D. S. (n.d.). Cloud Computing and SOA Convergence in "
      "Your Enterprise.\n\n"
      "Sosinsky, B. (n.d.). Cloud Computing Bible.\n\n"
      "Saurabh, K. (2011). Cloud Computing: Insights into New Era "
      "Infrastructure. Wiley India.";

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

          Text(courseNature, style: AppTextStyles.labelSmall),

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

          AppSpacing.md.h.verticalSpace,

          // Unit 7
          Text(unit7Title, style: AppTextStyles.titleLarge),

          AppSpacing.xxs.h.verticalSpace,

          Text(unit7Hours, style: AppTextStyles.labelSmall),

          AppSpacing.xs.h.verticalSpace,

          Padding(
            padding: bodyPadding,
            child: Text(unit7Topics, style: AppTextStyles.bodyMedium),
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
