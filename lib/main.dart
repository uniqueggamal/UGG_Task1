import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:internship_task/core/constants/routes.dart';
import 'package:internship_task/core/providers/nav_provider.dart';
import 'package:internship_task/core/providers/sub_provider.dart';
import 'package:internship_task/core/theme/app_theme.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();

  await authProvider.checkAuth();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => SubProvider()),
        ChangeNotifierProvider.value(value: authProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final authProvider = context.read<AuthProvider>();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          initialRoute: authProvider.authState
              ? AppRoutes.home
              : AppRoutes.login,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
