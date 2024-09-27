import 'package:flutter/material.dart';
import 'package:task_management/config/routes/routes.dart';

void onTapNextButton(context) {
  Navigator.pushNamed(context, Routes.home);
}

void onTapForgotPassword(context) {
  Navigator.pushNamed(context, Routes.emailAddress);
}

void onTapSignUp(context) {
  Navigator.pushNamed(context, Routes.signUp);
}
