import 'package:flutter/material.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/core/providers/sub_provider.dart';
import 'package:provider/provider.dart';

/// A tile widget for displaying subject information with tap handling
class SubjectTile extends StatelessWidget {
  final String subject;

  const SubjectTile(this.subject, {super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.read<NavProvider>();
    final subProvider = context.read<SubProvider>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: AppColors.surface,
        elevation: 0,
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.large),
          onTap: () => subProvider.subjectIndex(subject),
          child: Container(
            // color: AppColors.surface,
            constraints: const BoxConstraints(minHeight: 72),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.surface,
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
                    color: AppColors.surface,
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
}
