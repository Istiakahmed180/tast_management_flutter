import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/network/network_response.dart';
import 'package:task_management/network/network_service.dart';

// -------------------------------------------------------------------------- //
// Forgot Password Email Address Controller
// -------------------------------------------------------------------------- //
class ForgotPasswordEmailAddressController extends GetxController {
  final RxBool isProgress = false.obs;
  final TextEditingController emailController = TextEditingController();

  @override
  onClose() {
    super.onClose();
    emailController.dispose();
  }

  // ------------------------------------------------------------------------ //
  // Email Address Verification Function Start
  Future<void> emailAddressVerification(
      {required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      isProgress.value = true;
      final url =
          "${ApiPath.emailAddressVerify}/${emailController.text.trim()}";
      final NetworkResponse response =
          await NetworkService.getRequest(url: url);
      isProgress.value = false;
      if (response.isSuccess) {
        if (response.requestResponse["status"] == "success") {
          Get.toNamed(Routes.pinVerification);
          Fluttertoast.showToast(
              msg: response.requestResponse["data"],
              backgroundColor: AppColors.colorGreen);
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
          msg: "Fill up all required fields",
          backgroundColor: AppColors.colorOrange);
    }
  }
  // Email Address Verification Function End
  // ------------------------------------------------------------------------ //

  // ------------------------------------------------------------------------ //
  // Go To Sign In Function Start
  void goToSignIn() {
    Get.back();
  }
  // Email Address Verification Function End
  // ------------------------------------------------------------------------ //
}

// -------------------------------------------------------------------------- //
// Forgot Password Pin Verification Controller
// -------------------------------------------------------------------------- //
class ForgotPasswordPinVerificationController extends GetxController {
  final ForgotPasswordEmailAddressController
      forgotPasswordEmailAddressController =
      Get.put(ForgotPasswordEmailAddressController());
  final isProgress = false.obs;
  final RxString pinCode = "".obs;
  final RxBool pinFilled = false.obs;

  // ------------------------------------------------------------------------ //
  // Pin Verification Function Start
  Future<void> pinVerification() async {
    isProgress.value = true;
    final url =
        "${ApiPath.pinCodeVerify}/${forgotPasswordEmailAddressController.emailController.text}/$pinCode";
    final NetworkResponse response = await NetworkService.getRequest(url: url);
    isProgress.value = false;
    if (response.isSuccess) {
      if (response.requestResponse["status"] == "success") {
        Get.offNamed(Routes.setPassword);
        Fluttertoast.showToast(
            msg: response.requestResponse["data"],
            backgroundColor: AppColors.colorGreen);
      } else {
        Fluttertoast.showToast(
            msg: response.requestResponse["data"],
            backgroundColor: AppColors.colorRed);
      }
    } else {
      Fluttertoast.showToast(
          msg: response.errorMessage, backgroundColor: AppColors.colorRed);
    }
  }
  // Pin Verification Function End
  // ------------------------------------------------------------------------ //

  // ------------------------------------------------------------------------ //
  // Gp Tp Sign In Function Start
  void goToSignIn() {
    Get.offNamed(Routes.signIn);
  }
  // Gp Tp Sign In Function End
  // ------------------------------------------------------------------------ //
}

// -------------------------------------------------------------------------- //
// Forgot Password Set Password Controller
// -------------------------------------------------------------------------- //
class ForgotPasswordSetPasswordController extends GetxController {
  final ForgotPasswordEmailAddressController emailAddressController =
      Get.put(ForgotPasswordEmailAddressController());
  final ForgotPasswordPinVerificationController pinVerificationController =
      Get.put(ForgotPasswordPinVerificationController());
  final RxBool isProgress = false.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // ------------------------------------------------------------------------ //
  // Set Password Function Start
  Future<void> setPassword({required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        isProgress.value = true;
        final Map<String, dynamic> requestBody = {
          "email": emailAddressController.emailController.text,
          "OTP": pinVerificationController.pinCode.toString(),
          "password": passwordController.text
        };
        final NetworkResponse response = await NetworkService.postRequest(
            url: ApiPath.setPassword, requestBody: requestBody);
        isProgress.value = false;
        if (response.isSuccess) {
          if (response.requestResponse["status"] == "success") {
            Get.offNamed(Routes.signIn);
            passwordController.clear();
            confirmPasswordController.clear();
            emailAddressController.emailController.clear();
            pinVerificationController.pinCode.value = "";
            Fluttertoast.showToast(
                msg: response.requestResponse["data"],
                backgroundColor: AppColors.colorGreen);
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
            msg: "Password not match", backgroundColor: AppColors.colorOrange);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please fill up all required fields",
          backgroundColor: AppColors.colorOrange);
    }
  }
  // Set Password Function End
  // ------------------------------------------------------------------------ //

  // ------------------------------------------------------------------------ //
  // Gp Tp Sign In Function Start
  void goToSignIn() {
    Get.offNamed(Routes.signIn);
  }
  // Gp Tp Sign In Function End
  // ------------------------------------------------------------------------ //
}
