import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/constants/routes.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/core/providers/sub_provider.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/core/widgets/app_message.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? appTitle;

  const TopAppBar({super.key, this.appTitle});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8.0);

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Are you sure?', style: AppTextStyles.titleLarge),
          content: const Text('Do you want to logout from your account?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true || !context.mounted) return;

    final authProvider = context.read<AuthProvider>();

    try {
      await authProvider.logout();

      if (!context.mounted) return;

      AppMessage.show(
        context,
        message: 'Logout successful',
        type: MessageType.success,
      );

      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } catch (e) {
      if (!context.mounted) return;

      AppMessage.show(context, message: e.toString(), type: MessageType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();
    final subProvider = context.watch<SubProvider>();

    final isDashboard = navProvider.currentIndex == 0;
    final isAcademic = navProvider.currentIndex == 1;
    final isProfile = navProvider.currentIndex == 2;

    final title =
        appTitle ??
        (isDashboard
            ? 'Dashboard'
            : isAcademic
            ? subProvider.subIndex
            : isProfile
            ? 'My Profile'
            : '');

    // Back button is only shown inside an Academic subpage.
    final showBackButton = isAcademic && subProvider.backState;

    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      automaticallyImplyLeading: false,

      leading: showBackButton
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
        if (isDashboard)
          IconButton(
            onPressed: () => _confirmLogout(context),
            icon: Icon(Icons.logout, size: 25.r),
            color: AppColors.onPrimary,
            tooltip: 'Logout',
          ),
      ],
    );
  }
}
