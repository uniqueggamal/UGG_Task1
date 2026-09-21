import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/core/theme/app_spacing.dart';

class ProfileInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? content;
  final int maxLines;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.title,
    this.content,
    this.maxLines = 3,
  });

  @override
  State<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: widget.content, style: AppTextStyles.bodyMedium),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final hasOverflow = textPainter.didExceedMaxLines;

        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: AppSpacing.xxl.h),
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8.r,
                offset: Offset(0, 3.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(widget.icon, size: 20.r),

                      AppSpacing.sm.w.horizontalSpace,

                      Text(widget.title, style: AppTextStyles.bodyLarge),
                    ],
                  ),

                  Icon(
                    (widget.content == null || widget.content == "")
                        ? Icons.add
                        : Icons.mode_edit_outline,
                    size: 20.r,
                    color: AppColors.inactive,
                  ),
                ],
              ),

              AppSpacing.md.h.verticalSpace,

              Text(
                widget.content ?? "",
                maxLines: isExpanded ? null : widget.maxLines,
                overflow: isExpanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium,
              ),

              AppSpacing.xs.h.verticalSpace,

              if (hasOverflow) ...[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? "Show less" : "Show more",
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
