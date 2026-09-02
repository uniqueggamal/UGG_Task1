import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/providers/navProvider.dart';
import 'package:internship_task/screens/basePage.dart';
import 'package:internship_task/screens/loginPage.dart';
import 'package:internship_task/utils/app_styles.dart';
import 'package:provider/provider.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();

    final title = navProvider.currentIndex == 0
        ? "NCCS Internship"
        : navProvider.currentIndex == 1
        ? navProvider.subIndex
        : navProvider.currentIndex == 2
        ? "My Profile"
        : '';

    return Container(
      width: double.infinity,
      height: AppSpacing.topSection.h,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl.w),
      color: AppTextStyles.bgColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg.w,
          AppSpacing.topSection.h / 2.5,
          AppSpacing.xs.w,
          AppSpacing.xs.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Back button
            if (navProvider.backState)
              IconButton(
                onPressed: navProvider.defaultSubjectIndex,
                icon: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Icon(Icons.arrow_back, size: 25.r),
                ),
                color: AppTextStyles.titleColor,
              ),

            // Title
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.headingLarge.copyWith(
                  letterSpacing: 1.5,
                  color: AppTextStyles.titleColor,
                ),
              ),
            ),

            // Logout button - Home only
            if (navProvider.currentIndex == 0 || navProvider.currentIndex == 2)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  AppSpacing.lg.h,
                  0,
                  AppSpacing.lg.h,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          if (navProvider.currentIndex == 0) {
                            return const Loginscreen();
                          }

                          if (navProvider.currentIndex == 2) {
                            return const BasePage();
                            // return const SizedBox.shrink();
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    navProvider.currentIndex == 0
                        ? Icons.logout
                        : navProvider.currentIndex == 2
                        ? Icons.mode_edit_outline
                        : null,
                  ),
                  color: AppTextStyles.titleColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
