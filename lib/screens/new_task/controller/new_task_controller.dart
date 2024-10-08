import 'package:get/get.dart';
import 'package:task_management/config/routes/routes.dart';

class NewTaskController extends GetxController {
  void goToCreateNewTask() {
    Get.toNamed(Routes.createNewTask);
  }
}
