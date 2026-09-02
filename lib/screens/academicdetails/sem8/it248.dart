//This is IT ENtrepreneurship and Management
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/utils/app_styles.dart';

class It248 extends StatefulWidget {
  const It248({super.key});

  @override
  State<It248> createState() => _It248State();
}

class _It248State extends State<It248> {
  // =========================
  // COURSE INFORMATION
  // =========================

  final String courseCode = "IT 248";

  final String courseTitle = "IT Entrepreneurship and Management";

  final String semester = "BIM 8th Semester";

  final String courseNature = "Information Technology and Computing";

  final String creditHours = "3 Credit Hours";

  final String lectureHours = "48 Lecture Hours";

  // =========================
  // COURSE OBJECTIVE
  // =========================

  final String objective =
      "The main objective of this course is to equip students with the "
      "knowledge and skills necessary to launch and manage successful "
      "IT-based startups. Through real-world case studies and experiential "
      "learning projects, students will gain practical insights into the "
      "challenges and opportunities in the ICT sector.";

  // =========================
  // COURSE DESCRIPTION
  // =========================

  final String description =
      "This course is structured for a BIM program and focuses on the "
      "fundamentals of entrepreneurship, including idea generation, market "
      "research, business model development, and financial management. "
      "The course also covers legal and regulatory considerations, marketing "
      "strategies, leadership, and corporate social responsibility.";

  // =========================
  // UNIT 1
  // =========================

  final String unit1Title = "Foundations of Entrepreneurship";

  final String unit1Hours = "6 Lecture Hours";

  final String unit1Topics =
      "Definition and Importance of Entrepreneurship\n"
      "Types of Entrepreneurs\n"
      "Key Characteristics of Successful Entrepreneurs\n"
      "Entrepreneurship Ecosystem\n"
      "Role of ICT in Entrepreneurship";

  final String unit1CaseStudy =
      "Success story of e-Sewa or Khalti and its impact on fintech industries.";

  // =========================
  // UNIT 2
  // =========================

  final String unit2Title = "Idea Generation and Market Research";

  final String unit2Hours = "10 Lecture Hours";

  final String unit2Topics =
      "Techniques for Creative Thinking\n"
      "Market Needs Identification\n"
      "Evaluating Business Ideas\n"
      "Current Technology Trend Analysis\n"
      "Prototyping Development\n"
      "Defining Target Markets\n"
      "Competitor Analysis Tools\n"
      "Consumer Behavior Insight";

  final String unit2CaseStudy =
      "Pathao: Nepal ride-share services market entry strategies and adaptations.";

  // =========================
  // UNIT 3
  // =========================

  final String unit3Title =
      "Business Model Development and Crafting a Business Plan";

  final String unit3Hours = "10 Lecture Hours";

  final String unit3Topics =
      "Business Model Canvas Framework\n"
      "Identifying Revenue Sources\n"
      "Cost Structure Analysis\n"
      "Sustainable Business Models\n"
      "Essential Elements of a Business Plan\n"
      "Financial Projections Development\n"
      "Marketing Strategy Formulation\n"
      "Operational Planning Essentials\n"
      "Risk Management Strategies";

  final String unit3CaseStudy =
      "Business plans from emerging Nepali tech startups.";

  // =========================
  // UNIT 4
  // =========================

  final String unit4Title = "Legal and Regulatory Framework";

  final String unit4Hours = "6 Lecture Hours";

  final String unit4Topics =
      "Concept of Nepali Business Laws for Startups\n"
      "Intellectual Property Rights (IPR)\n"
      "Licensing and Permits Required for Startups\n"
      "Taxation Basics for Businesses\n"
      "Compliance with Labor Laws";

  final String unit4CaseStudy =
      "Legal challenges faced by Nepali startups in the IT sector.";

  // =========================
  // UNIT 5
  // =========================

  final String unit5Title =
      "Financial Management and Marketing Strategies for Startups";

  final String unit5Hours = "10 Lecture Hours";

  final String unit5Topics =
      "Funding Sources for Startups\n"
      "Budgeting Techniques for New Ventures\n"
      "Cash Flow Management Essentials\n"
      "Financial Reporting Requirements\n"
      "Developing a Marketing Strategy\n"
      "Digital Marketing Techniques\n"
      "Sales Techniques for Startups\n"
      "Customer Relationship Management (CRM)\n"
      "Brand Building Essentials";

  final String unit5CaseStudy =
      "The marketing strategies that propelled MakeMyTrip's growth.";

  // =========================
  // UNIT 6
  // =========================

  final String unit6Title = "Leadership and Corporate Social Responsibility";

  final String unit6Hours = "6 Lecture Hours";

  final String unit6Topics =
      "Leadership Styles in Entrepreneurship\n"
      "Building Effective Teams\n"
      "Conflict Resolution Techniques\n"
      "Motivating Employees in Startups\n"
      "Networking Skills for Entrepreneurs\n"
      "Corporate Social Responsibility (CSR)\n"
      "Sustainability Practices for Startups\n"
      "Ethical Marketing Strategies";

  final String unit6CaseStudy =
      "Tata Group's CSR initiatives in India and their impact on society.";

  // =========================
  // SUGGESTED READINGS
  // =========================

  final String suggestedReadings =
      "Feld, B., & Mendelson, J. (2012). Venture Deals: Be Smarter Than "
      "Your Lawyer and Venture Capitalist. Wiley.\n\n"
      "Horowitz, B. (2014). The Hard Thing About Hard Things: Building a "
      "Business When There Are No Easy Answers. Harper Business.\n\n"
      "Kawasaki, G. (2015). The Art of the Start 2.0. Portfolio/Penguin.\n\n"
      "Kuratko, D. F. (2023). Entrepreneurship: Theory, Process, Practice "
      "(12th ed.). Cengage Learning.\n\n"
      "Ries, E. (2011). The Lean Startup. Crown Business.\n\n"
      "Thiel, P. (2014). Zero to One: Notes on Startups, or How to Build "
      "the Future. Crown Business.";

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

          // Text(courseNature, style: AppTextStyles.titleMedium),
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
          AppSpacing.xs.h.verticalSpace,

          Text(
            unit1CaseStudy,
            style: AppTextStyles.bodyMedium.copyWith(
              fontStyle: FontStyle.italic,
            ),
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
          AppSpacing.xs.h.verticalSpace,

          Text(
            unit2CaseStudy,
            style: AppTextStyles.bodyMedium.copyWith(
              fontStyle: FontStyle.italic,
            ),
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
          AppSpacing.xs.h.verticalSpace,

          Text(
            unit3CaseStudy,
            style: AppTextStyles.bodyMedium.copyWith(
              fontStyle: FontStyle.italic,
            ),
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
          AppSpacing.xs.h.verticalSpace,

          Text(
            unit4CaseStudy,
            style: AppTextStyles.bodyMedium.copyWith(
              fontStyle: FontStyle.italic,
            ),
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
          AppSpacing.xs.h.verticalSpace,

          Text(
            unit5CaseStudy,
            style: AppTextStyles.bodyMedium.copyWith(
              fontStyle: FontStyle.italic,
            ),
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
          AppSpacing.xs.h.verticalSpace,

          Text(
            unit6CaseStudy,
            style: AppTextStyles.bodyMedium.copyWith(
              fontStyle: FontStyle.italic,
            ),
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
