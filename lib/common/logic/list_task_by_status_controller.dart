import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/network/network_response.dart';
import 'package:task_management/network/network_service.dart';

// -------------------------------------------------------------------------- //
// New Task Controller Controller
// -------------------------------------------------------------------------- //
class ListTaskByStatusController extends GetxController {
  final RxBool isProgress = false.obs;
  final RxList<Map<String, dynamic>> taskList = <Map<String, dynamic>>[].obs;

  // ------------------------------------------------------------------------ //
  // Get List Task By Status Function Start
  Future<void> getTaskByStatus({required String status}) async {
    isProgress.value = true;
    final url = "${ApiPath.taskListByStatus}/$status";
    final NetworkResponse response = await NetworkService.getRequest(url: url);
    isProgress.value = false;
    if (response.isSuccess) {
      if (response.requestResponse["status"] == "success") {
        final jsonResponse =
            List<Map<String, dynamic>>.from(response.requestResponse["data"]);
        taskList.clear();
        taskList.addAll(jsonResponse);
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
  // Get List Task By Status Function End
  // ------------------------------------------------------------------------ //

// ------------------------------------------------------------------------ //
  // Delete Task By ID Function Start
  Future<void> deleteTaskByID(
      {required String taskId, required String status}) async {
    isProgress.value = true;
    final url = "${ApiPath.deleteTask}/$taskId";
    final NetworkResponse response = await NetworkService.getRequest(url: url);
    isProgress.value = false;
    if (response.isSuccess) {
      if (response.requestResponse["status"] == "success") {
        taskList.clear();
        getTaskByStatus(status: status);
        Fluttertoast.showToast(
            msg: "Task Delete Complete", backgroundColor: AppColors.colorGreen);
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
// Delete Task By ID Function End
// ------------------------------------------------------------------------ //
}
