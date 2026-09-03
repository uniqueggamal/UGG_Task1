import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/shared/utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _infoRow({required String label, required String value}) {
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

    var horizontalLine = Container(
      color: Colors.black,
      width: MediaQuery.sizeOf(context).width * 0.80,
      height: 2,
    );

    var container1 = Container(
      width: double.infinity,
      height: AppSpacing.control.h,
      // margin: EdgeInsets.all(AppSpacing.xl.w),
      decoration: BoxDecoration(
        color: AppColors.highlightSurface.withOpacity(0.8),
      ),
      child: Center(
        child: Text(
          "Identity Card",
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.textMuted,
            letterSpacing: 5,
          ),
        ),
      ),
    );

    var container2 = Container(
      padding: EdgeInsets.all(AppSpacing.xxs.r),
      decoration: BoxDecoration(border: Border.all(width: 0.1)),
      child: Image.asset("assets/pp.jpg", width: 175.h),
    );

    var container3 = Container(
      child: Column(
        children: [
          Text(
            "Unique G. Gamal",
            style: AppTextStyles.headingLarge.copyWith(letterSpacing: 1.5),
          ),
          Text(
            "Intern",
            style: AppTextStyles.titleLarge.copyWith(
              letterSpacing: 1,
              fontWeight: FontWeight.w400,
              fontSize: 24.sp,
            ),
          ),
        ],
      ),
    );

    var container4 = Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxxl.w,
        AppSpacing.xxxl.h,
        AppSpacing.xxxl.w,
        AppSpacing.xxxl.r,
      ),
      child: Column(
        children: [
          _infoRow(label: "ID", value: "NCCSINTERN1234"),
          _infoRow(label: "DOB", value: "2000-01-01"),
          _infoRow(label: "Phone", value: "9876543210"),
          _infoRow(label: "Email", value: "uniquegamal@gmail.com"),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: AppTextStyles.bgBoxColor),
            child: Column(
              children: [
                SizedBox(height: 0.5),
                container1,
                SizedBox(height: AppSpacing.xxl.h),
                container2,
                SizedBox(height: AppSpacing.xxl.h),
                container3,
                SizedBox(height: AppSpacing.xxl.h),
                horizontalLine,
                container4,
              ],
            ),
          ),
        );
      },
    );
  }
}
