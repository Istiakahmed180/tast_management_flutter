import 'package:flutter/material.dart';
import 'package:task_management/config/routes/routes.dart';

void onTapNextButton(context) {
Navigator.pushNamed(context, Routes.signIn);
}

void onTapSignIn(context) {
  Navigator.pushNamed(context, Routes.signIn);
}
