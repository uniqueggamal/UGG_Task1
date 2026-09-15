import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_styles.dart';

class InfoRowsSection extends StatelessWidget {
  const InfoRowsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxxl.w,
        AppSpacing.xxxl.h,
        AppSpacing.xxxl.w,
        AppSpacing.xxxl.r,
      ),
      child: Column(
        children: [
          _InfoRow(label: "ID", value: "NCCSINTERN1234"),
          _InfoRow(label: "DOB", value: "2000-01-01"),
          _InfoRow(label: "Phone", value: "9876543210"),
          _InfoRow(label: "Email", value: "uniquegamal@gmail.com"),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.20,
              child: Text(label, style: AppTextStyles.titleMedium),
            ),
            Expanded(
              child: Text(":\t\t\t" + value, style: AppTextStyles.bodyMedium),
            ),
          ],
        ),
        AppSpacing.lg.h.verticalSpace,
      ],
    );
  }
}
