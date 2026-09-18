import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/constants/routes.dart';
import 'package:internship_task/core/widgets/app_message.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/core/providers/sub_provider.dart';
import 'package:internship_task/features/auth/screens/login_screen.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8.0);

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();
    final subProvider = context.watch<SubProvider>();
    final authProvider = context.watch<AuthProvider>();

    final title = navProvider.currentIndex == 0
        ? "Dashboard"
        : navProvider.currentIndex == 1
        ? subProvider.subIndex
        : navProvider.currentIndex == 2
        ? "My Profile"
        : '';
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      automaticallyImplyLeading: false,

      leading: subProvider.backState
          ? IconButton(
              onPressed: subProvider.defaultSubjectIndex,
              icon: Icon(Icons.arrow_back, size: 25.r),
              color: AppColors.onPrimary,
            )
          : null,
      title: Text(
        title,
        style: AppTextStyles.headingLarge.copyWith(
          letterSpacing: 1.5,
          color: AppColors.onPrimary,
        ),
        overflow: TextOverflow.ellipsis,
      ),

      actions: [
        if (navProvider.currentIndex == 0)
          IconButton(
            onPressed: () {
              if (navProvider.currentIndex == 0) {
                authProvider.logout();
                AppMessage.show(
                  context,
                  message: "Logout Successfully",
                  type: MessageType.success,
                );
                Navigator.pushNamed(context, AppRoutes.login);
              }
            },
            icon: Icon(Icons.logout, size: 25.r),
            color: AppColors.onPrimary,
          ),
      ],
    );
  }
}
