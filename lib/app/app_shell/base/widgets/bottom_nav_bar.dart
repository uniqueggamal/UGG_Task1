import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/core/theme/app_styles.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();

    final activeColor = Colors.purple;
    final inactiveColor = Colors.grey;

    final activeIconSize = 40.r;
    final inactiveIconSize = 30.r;

    final activeStyleText = AppTextStyles.labelLarge.copyWith(
      color: activeColor,
    );

    final inactiveStyleText = AppTextStyles.labelSmall.copyWith(
      color: inactiveColor,
    );

    return Container(
      // height: AppSpacing.bottomSection.h,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg.w,
        vertical: AppSpacing.xs.h,
      ),
      decoration: BoxDecoration(
        color: AppTextStyles.titleColor,
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),

      child: Row(
        children: [
          Expanded(
            child: _NavItem(
              icon: Icons.home,
              label: 'Home',
              isActive: navProvider.currentIndex == 0,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              activeIconSize: activeIconSize,
              inactiveIconSize: inactiveIconSize,
              activeStyleText: activeStyleText,
              inactiveStyleText: inactiveStyleText,
              onTap: () => navProvider.changeIndex(0),
            ),
          ),

          Expanded(
            child: _NavItem(
              icon: Icons.book,
              label: 'Subjects',
              isActive: navProvider.currentIndex == 1,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              activeIconSize: activeIconSize,
              inactiveIconSize: inactiveIconSize,
              activeStyleText: activeStyleText,
              inactiveStyleText: inactiveStyleText,
              onTap: () => navProvider.changeIndex(1),
            ),
          ),

          Expanded(
            child: _NavItem(
              icon: Icons.person,
              label: 'Profile',
              isActive: navProvider.currentIndex == 2,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              activeIconSize: activeIconSize,
              inactiveIconSize: inactiveIconSize,
              activeStyleText: activeStyleText,
              inactiveStyleText: inactiveStyleText,
              onTap: () => navProvider.changeIndex(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _NavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required Color inactiveColor,
    required double activeIconSize,
    required double inactiveIconSize,
    required TextStyle activeStyleText,
    required TextStyle inactiveStyleText,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isActive ? activeIconSize : inactiveIconSize,
            color: isActive ? activeColor : inactiveColor,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: isActive ? activeStyleText : inactiveStyleText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
