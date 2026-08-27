import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/providers/navProvider.dart';
import 'package:internship_task/screens/basePage.dart';
import 'package:internship_task/utils/app_styles.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final username = TextEditingController(text: "NCCSIntern");
  final password = TextEditingController(text: "2026");
  bool hidePassword = true;
  var labelStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppTextSizes.s14,
    color: Colors.grey,
  );
  var headingStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: AppTextSizes.s24,
  );
  var subHeadingStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppTextSizes.s14,
  );
  var boxHeight = AppSpacing.v60;
  var boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.r5),
    border: Border.all(color: Colors.black),
  );
  var appBarColor = Colors.purple;
  var boxColor = Colors.white;
  var headingTitleStyle = TextStyle(
    fontFamily: "Nunito",
    fontSize: 84,
    letterSpacing: 4,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        toolbarHeight: 150.h,
        title: Center(child: Text("NCCS", style: headingTitleStyle)),
      ),
      backgroundColor: appBarColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                    bottomLeft: Radius.circular(0.r),
                    bottomRight: Radius.circular(0.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.h30,
                    vertical: AppSpacing.v10,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Welcome to NCCS Internship ",
                                style: headingStyle,
                              ),
                              SizedBox(height: AppSpacing.v4),
                              Text(
                                "Please login to continue",
                                style: labelStyle.copyWith(
                                  fontSize: AppTextSizes.s16,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSpacing.v24),
                        Row(
                          children: [
                            4.horizontalSpace,
                            Text(
                              "Username",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            AppSpacing.h20,
                            AppSpacing.v20,
                            AppSpacing.h20,
                            AppSpacing.v20,
                          ),
                          height: boxHeight,
                          width: double.infinity,
                          decoration: boxDecoration,
                          child: TextField(
                            style: TextStyle(fontSize: AppTextSizes.s16),
                            controller: username,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              // contentPadding: EdgeInsets.symmetric(horizontal: 30),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSpacing.v24),
                        Row(
                          children: [
                            4.horizontalSpace,
                            Text(
                              "Password",
                              style: subHeadingStyle.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            AppSpacing.h6,
                            AppSpacing.v10,
                            AppSpacing.h20,
                            AppSpacing.v10,
                          ),
                          width: double.infinity,
                          height: boxHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadius.r4),
                            border: Border.all(width: 1, color: Colors.black),
                          ),
                          child: TextField(
                            style: TextStyle(fontSize: AppTextSizes.s16),
                            controller: password,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                left: AppSpacing.h20,
                              ),
                              suffixIcon: IconButton(
                                iconSize: 25,
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: Icon(
                                  !hidePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            obscureText: hidePassword,
                          ),
                        ),
                        SizedBox(height: AppSpacing.v40),
                        SizedBox(
                          height: AppSpacing.v60,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (username.text == 'NCCSIntern') {
                                if (password.text == '2026') {
                                  navProvider.login();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BasePage(),
                                    ),
                                  );
                                }
                              }
                              return;
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.purple,
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                Colors.white,
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: AppTextSizes.s16),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSpacing.v10),

                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Don't have an accout? Create one",
                              style: labelStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
