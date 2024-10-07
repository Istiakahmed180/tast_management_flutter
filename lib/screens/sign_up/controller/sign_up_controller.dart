import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/network/network_response.dart';
import 'package:task_management/network/network_service.dart';

class SignUpController extends GetxController {
  final RxBool isProgress = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
  }

  Future<void> signUp({required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      isProgress.value = true;
      final Map<String, dynamic> requestBody = {
        "email": emailController.text.trim(),
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "mobile": mobileController.text.trim(),
        "password": passwordController.text,
        "photo": ""
      };
      final NetworkResponse response = await NetworkService.postRequest(
          url: ApiPath.registration, requestBody: requestBody);
      isProgress.value = false;
      if (response.isSuccess) {
        if (response.requestResponse["status"] == "success") {
          Fluttertoast.showToast(
              msg: "Account create complete",
              backgroundColor: AppColors.colorGreen);
          Get.back();
          clearTextFields();
        } else {
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

  void clearTextFields() {
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    mobileController.clear();
    passwordController.clear();
  }

  void goToSignIn() {
    Get.back();
  }
}
