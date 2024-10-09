import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_management/common/logic/auth_controller.dart';
import 'package:task_management/common/logic/user_details_controller.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/network/network_response.dart';
import 'package:task_management/network/network_service.dart';

// -------------------------------------------------------------------------- //
// Profile Controller
// -------------------------------------------------------------------------- //
class ProfileController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final UserDetailsController userDetailsController =
      Get.put(UserDetailsController());
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

  // ------------------------------------------------------------------------ //
  // Update Profile Function Start
  Future<void> updateProfile({required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      isProgress.value = true;
      final Map<String, dynamic> requestBody = {
        "email": emailController.text.trim(),
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "mobile": mobileController.text.trim(),
        "password": passwordController.text
      };
      final NetworkResponse response = await NetworkService.postRequest(
          url: ApiPath.profileUpdate, requestBody: requestBody);
      isProgress.value = false;
      if (response.isSuccess) {
        if (response.requestResponse["status"] == "success") {
          clearTextFields();
          authController.logout();
          Fluttertoast.showToast(
              msg: "Profile Update Complete",
              backgroundColor: AppColors.colorGreen);
        } else {
          Fluttertoast.showToast(
              msg: response.requestResponse["status"],
              backgroundColor: AppColors.colorRed);
        }
      } else {
        Fluttertoast.showToast(
            msg: response.errorMessage, backgroundColor: AppColors.colorRed);
      }
    }
  }
  // Update Profile Function End
  // ------------------------------------------------------------------------ //

  // ------------------------------------------------------------------------ //
  // Clear Text Fields Function Start
  void clearTextFields() {
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    mobileController.clear();
    passwordController.clear();
  }
  // Clear Text Fields Function Start
  // ------------------------------------------------------------------------ //
}
