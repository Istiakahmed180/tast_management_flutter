import 'package:flutter/material.dart';
import 'package:task_management/config/theme/theme.dart';
import 'package:task_management/screens/splash/view/splash_screen.dart';

class TaskManagement extends StatelessWidget {
  const TaskManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(context),
      home: const SplashScreen(),
    );
  }
}
