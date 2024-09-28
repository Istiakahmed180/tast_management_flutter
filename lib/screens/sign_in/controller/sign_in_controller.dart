import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/helpers/helper_snackbar.dart';

class SignInController extends GetxController {
  final RxBool isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> onTapSignInAction(context) async {
    isLoading.value = true;
    try {
      final Map<String, String> headers = {"Content-Type": "application/json"};

      final Map<String, dynamic> requestBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      final response = await http.post(Uri.parse(ApiPath.login),
          headers: headers, body: jsonEncode(requestBody));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse["status"] == "success") {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("user_token", jsonResponse["token"]);

          HelperSnackbar.showSnackBar(
              context: context,
              message: "Login Success",
              backgroundColor: AppColors.colorGreen);
          clearFormFields();
          Navigator.pushNamed(context, Routes.home);
        } else {
          HelperSnackbar.showSnackBar(
              context: context,
              message: jsonResponse["data"],
              backgroundColor: AppColors.colorRed);
        }
      }
    } catch (e) {
      HelperSnackbar.showSnackBar(
          context: context,
          message: "An Error Occurred!",
          backgroundColor: AppColors.colorRed);
    } finally {
      isLoading.value = false;
    }
  }

  void onTapForgotPasswordAction(context) {
    Navigator.pushNamed(context, Routes.emailAddress);
  }

  void onTapSignUpAction(context) {
    Navigator.pushNamed(context, Routes.signUp);
  }

  void clearFormFields() {
    emailController.clear();
    passwordController.clear();
  }
}
