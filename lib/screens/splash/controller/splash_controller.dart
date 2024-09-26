import 'package:flutter/material.dart';
import 'package:task_management/config/routes/routes.dart';

Future<void> moveToNextScreen(context) async {
  await Future.delayed(const Duration(seconds: 3));
  Navigator.pushReplacementNamed(context, Routes.signIn);
}
