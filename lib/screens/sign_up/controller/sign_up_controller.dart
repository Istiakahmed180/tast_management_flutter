import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/helpers/helper_snackbar.dart';

class SignUpController extends GetxController {
  final RxBool isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> onTapSignUpAction(context) async {
    isLoading.value = true;
    try {
      final Map<String, String> headers = {"Content-Type": "application/json"};

      final Map<String, dynamic> requestBody = {
        "email": emailController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "mobile": mobileController.text,
        "password": passwordController.text
      };

      final response = await http.post(
        Uri.parse(ApiPath.registration),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse["status"] == "success") {
          HelperSnackbar.showSnackBar(
              context: context,
              message: "Registration Complete",
              backgroundColor: AppColors.colorGreen);
          clearFormFields();
          Navigator.pushNamed(context, Routes.signIn);
        } else {
          HelperSnackbar.showSnackBar(
              context: context,
              message: "Registration Failed! Try again.",
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

  void clearFormFields() {
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    mobileController.clear();
    passwordController.clear();
  }

  void onTapSignIn(context) {
    Navigator.pushNamed(context, Routes.signIn);
  }
}
