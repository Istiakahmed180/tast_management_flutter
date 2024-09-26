import 'package:flutter/material.dart';
import 'package:task_management/config/routes/routes.dart';

void onTapNextButton() {
  // TODO: implement on tap next button
}

void onTapForgotPassword(context) {
  Navigator.pushNamed(context, Routes.emailAddress);
}

void onTapSignUp(context) {
  Navigator.pushNamed(context, Routes.signUp);
}
