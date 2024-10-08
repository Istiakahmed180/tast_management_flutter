import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/network/network_response.dart';
import 'package:task_management/network/network_service.dart';

class UserDetailsController extends GetxController {
  final isProgress = false.obs;
  final Map<String, dynamic> userData = <String, dynamic>{}.obs;

  Future<void> getUserDetails() async {
    isProgress.value = true;
    final NetworkResponse response =
        await NetworkService.getRequest(url: ApiPath.userProfile);
    isProgress.value = false;
    if (response.isSuccess) {
      final Map<String, dynamic> user = response.requestResponse["data"][0];
      userData.assignAll(user);
    } else {
      Fluttertoast.showToast(
          msg: response.errorMessage, backgroundColor: AppColors.colorRed);
    }
  }
}
