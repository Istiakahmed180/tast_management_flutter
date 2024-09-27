import 'package:flutter/material.dart';
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/helpers/helper_snackbar.dart';

// -------------------------------------------------------------------------- //
// Email Address Component Actions
// -------------------------------------------------------------------------- //
void onTapEmailAddressAction(context) {
  Navigator.pushNamed(context, Routes.pinVerification);
}

void onTapEmailAddressSignInAction(context) {
  Navigator.pushNamed(context, Routes.signIn);
}

// -------------------------------------------------------------------------- //
// Pin Verification Component Actions
// -------------------------------------------------------------------------- //
void onTapPinVerifyActionVerifyAction(
    BuildContext context, GlobalKey<FormState> formKey, String currentText) {
  if (formKey.currentState!.validate()) {
    if (currentText.length == 6 && currentText == "123456") {
      Navigator.pushNamed(context, Routes.setPassword);
    } else {
      HelperSnackbar.showSnackBar(
          context: context,
          message: "Invalid pin. Please try again.",
          backgroundColor: AppColors.colorRed);
    }
  }
}

void onTapPinVerificationSignInAction(context) {
  Navigator.pushNamed(context, Routes.signIn);
}

// -------------------------------------------------------------------------- //
// Set Password Component Actions
// -------------------------------------------------------------------------- //
void onTapSetPasswordConfirmAction(context) {}

void onTapSetPasswordSignInAction(context) {
  Navigator.pushNamed(context, Routes.signIn);
}
