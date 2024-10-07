import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_management/common/logic/auth_controller.dart';
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/network/network_response.dart';
import 'package:task_management/network/network_service.dart';

// -------------------------------------------------------------------------- //
// Sign In Controller
// -------------------------------------------------------------------------- //
class SignInController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final RxBool isProgress = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  // ------------------------------------------------------------------------ //
  // Sign In Function Start
  Future<void> signIn({required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
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
          authController.saveToken(token);
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
    } else {
      Fluttertoast.showToast(
          msg: "Please fill up all required field",
          backgroundColor: AppColors.colorOrange);
    }
  }

  // Sign In Function End
  // ------------------------------------------------------------------------ //

  // ------------------------------------------------------------------------ //
  // Go To Sign Up Function Start
  void goToSignUp() {
    Get.toNamed(Routes.signUp);
  }

  // Go To Sign Up Function End
  // ------------------------------------------------------------------------ //

  // ------------------------------------------------------------------------ //
  // Go To Forgot Password Function Start
  void goToForgotPassword() {
    Get.toNamed(Routes.emailAddress);
  }

  // Go To Forgot Password Function End
  // ------------------------------------------------------------------------ //

  // ------------------------------------------------------------------------ //
  // Clear Text Field Function Start
  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
  }

  // Clear Text Field Function End
  // ------------------------------------------------------------------------ //
}
