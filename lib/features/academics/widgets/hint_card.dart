import 'package:flutter/material.dart';
import 'package:internship_task/core/theme/app_radius.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';

/// A hint/information card widget with an icon and message
class HintCard extends StatelessWidget {
  final String message;

  const HintCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
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
              message,
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
}
