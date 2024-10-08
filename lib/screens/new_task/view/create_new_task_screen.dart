import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/logic/user_details_controller.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/common/widgets/common_app_bar.dart';

class CreateNewTaskScreen extends StatelessWidget {
  const CreateNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDetailsController userDetailsController =
        Get.put(UserDetailsController());
    return const Scaffold(
        appBar: CommonAppBar(), body: AppBackground(child: Text("")));
  }
}
