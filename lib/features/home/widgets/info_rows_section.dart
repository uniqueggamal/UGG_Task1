import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';

class InfoRowsSection extends StatelessWidget {
  const InfoRowsSection({
    super.key,
    required this.values,
  });

  final List<({String label, String? value})> values;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxxl.w,
        AppSpacing.xxxl.h,
        AppSpacing.xxxl.w,
        AppSpacing.xxxl.h,
      ),
      child: Column(
        children: values
            .map(
              (item) => _InfoRow(
                label: item.label,
                value: item.value,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.20,
              child: Text(
                label,
                style: AppTextStyles.titleMedium,
              ),
            ),
            Expanded(
              child: Text(
                ':   ${value?.isNotEmpty == true ? value : 'Not provided'}',
                style: AppTextStyles.bodyMedium,
              ),
            ),
          ],
        ),
        AppSpacing.lg.h.verticalSpace,
      ],
    );
  }
}