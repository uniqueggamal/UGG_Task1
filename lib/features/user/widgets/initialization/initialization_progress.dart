import 'package:flutter/material.dart';

import 'package:internship_task/core/theme/app_spacing.dart';

class InitializationProgress extends StatelessWidget {
  const InitializationProgress({
    super.key,
    required this.currentStep,
    required this.stepTitles,
  });

  final int currentStep;
  final List<String> stepTitles;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg.w,
        AppSpacing.md.h,
        AppSpacing.lg.w,
        AppSpacing.sm.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${currentStep + 1} of ${stepTitles.length}',
            style: textTheme.bodySmall,
          ),

          SizedBox(height: AppSpacing.sm.h),

          Row(
            children: List.generate(stepTitles.length, (index) {
              final isActive = index <= currentStep;

              return Expanded(
                child: Container(
                  height: 5,
                  margin: EdgeInsets.only(
                    right: index == stepTitles.length - 1 ? 0 : 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: AppSpacing.sm.h),

          Text(
            stepTitles[currentStep],
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
