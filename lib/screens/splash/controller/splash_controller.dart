import 'package:flutter/material.dart';
import 'package:task_management/screens/sign_in/view/sign_in_screen.dart';

Future<void> moveToNextScreen(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 3));
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const SignInScreen()),
  );
}
