import 'package:flutter/material.dart';
import 'package:internship_task/providers/nav_provider.dart';
import 'package:internship_task/screens/base/base_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => NavProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 915),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const BaseScreen(),
      ),
    );
  }
}
