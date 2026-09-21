import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_dimensions.dart';

import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/widgets/app_button.dart';

class InitializationNavigation extends StatelessWidget {
  const InitializationNavigation({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onBack,
    required this.onContinue,
  });

  final int currentStep;
  final int totalSteps;

  final VoidCallback onBack;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final isFirstStep = currentStep == 0;
    final isLastStep = currentStep == totalSteps - 1;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg.w,
          AppSpacing.sm.h,
          AppSpacing.lg.w,
          AppSpacing.lg.h,
        ),
        child: Row(
          children: [
            if (!isFirstStep) ...[
              Expanded(
                child: SizedBox(
                  height: AppDimensions.buttonHeight,
                  child: OutlinedButton(
                    onPressed: onBack,
                    child: const Text('Back'),
                  ),
                ),
              ),

              SizedBox(width: AppSpacing.sm.w),
            ],

            Expanded(
              flex: 2,
              child: AppButton(
                text: isLastStep ? 'Finish' : 'Continue',
                onPressed: onContinue,
                borderRadius: 12.r,
                height: AppDimensions.buttonHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
