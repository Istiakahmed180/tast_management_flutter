import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/app.dart';
import 'package:task_management/common/logic/user_token_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserTokenController());
  runApp(const TaskManagement());
}
