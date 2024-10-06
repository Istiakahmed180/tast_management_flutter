import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/network/network_response.dart';
import 'package:task_management/network/network_service.dart';

class SignInController extends GetxController {
  final RxBool isProgress = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    isProgress.value = true;
    final Map<String, dynamic> requestBody = {
      "email": emailController.text.trim(),
      "password": passwordController.text
    };
    final NetworkResponse response = await NetworkService.postRequest(
        url: ApiPath.login, requestBody: requestBody);
    isProgress.value = false;
    if (response.isSuccess) {
      if (response.requestResponse["status"] == "success") {
        final token = response.requestResponse["token"];
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);
        }
        Fluttertoast.showToast(
            msg: "Login Success", backgroundColor: AppColors.colorGreen);
        Get.offAllNamed(Routes.home);
        clearTextFields();
      } else if (response.requestResponse["status"] == "fail") {
        Fluttertoast.showToast(
            msg: response.requestResponse["data"],
            backgroundColor: AppColors.colorRed);
      }
    } else {
      Fluttertoast.showToast(
          msg: response.errorMessage, backgroundColor: AppColors.colorRed);
    }
  }

  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> logOut() async {
    Fluttertoast.showToast(
        msg: "Logout Success", backgroundColor: AppColors.colorGreen);
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(Routes.signIn);
  }
}
