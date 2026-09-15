import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/app/app_shell/base/screens/base_screen.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/features/auth/screens/login_screen.dart';
import 'package:internship_task/core/theme/app_styles.dart';
import 'package:provider/provider.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8.0);

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();

    final title = navProvider.currentIndex == 0
        ? "Dashboard"
        : navProvider.currentIndex == 1
        ? navProvider.subIndex
        : navProvider.currentIndex == 2
        ? "My Profile"
        : '';
    return AppBar(
      backgroundColor: AppTextStyles.bgColor,
      elevation: 0,
      automaticallyImplyLeading: false,

      leading: navProvider.backState
          ? IconButton(
              onPressed: navProvider.defaultSubjectIndex,
              icon: Icon(Icons.arrow_back, size: 25.r),
              color: AppTextStyles.titleColor,
            )
          : null,
      title: Text(
        title,
        style: AppTextStyles.headingLarge.copyWith(
          letterSpacing: 1.5,
          color: AppTextStyles.titleColor,
        ),
        overflow: TextOverflow.ellipsis,
      ),

      actions: [
        if (navProvider.currentIndex == 0 || navProvider.currentIndex == 2)
          IconButton(
            onPressed: () {
              if (navProvider.currentIndex == 0) {
                navProvider.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
            icon: Icon(
              navProvider.currentIndex == 0
                  ? Icons.logout
                  : Icons.mode_edit_outline,
              size: 25.r,
            ),
            color: AppTextStyles.titleColor,
          ),
      ],
    );
  }
}
