import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/network/network_response.dart';
import 'package:task_management/network/network_service.dart';

// -------------------------------------------------------------------------- //
// New Task Controller Controller
// -------------------------------------------------------------------------- //
class NewTaskController extends GetxController {
  // ------------------------------------------------------------------------ //
  // Go To Create New Task Function Start
  void goToCreateNewTask() {
    Get.toNamed(Routes.createNewTask);
  }
  // Go To Create New Task Function End
  // ------------------------------------------------------------------------ //
}

// -------------------------------------------------------------------------- //
// Create New Task Controller Controller
// -------------------------------------------------------------------------- //
class CreateNewTaskController extends GetxController {
  final RxBool isProgress = false.obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  onClose() {
    super.onClose();
    titleController.dispose();
    descriptionController.dispose();
  }

  // ------------------------------------------------------------------------ //
  // Create New Task Function Start
  Future<void> createNewTask({required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      isProgress.value = true;
      final Map<String, dynamic> requestBody = {
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "status": "New"
      };
      final NetworkResponse response = await NetworkService.postRequest(
          url: ApiPath.createNewTask, requestBody: requestBody);
      isProgress.value = false;
      if (response.isSuccess) {
        if (response.requestResponse["status"] == "success") {
          Get.back();
          titleController.clear();
          descriptionController.clear();
          Fluttertoast.showToast(
              msg: "New task create complete",
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
  // Create New Task Function End
  // ------------------------------------------------------------------------ //
}
