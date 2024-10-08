import 'package:flutter/material.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/common/widgets/common_app_bar.dart';

class CreateNewTaskScreen extends StatelessWidget {
  const CreateNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CommonAppBar(), body: AppBackground(child: Text("")));
  }
}
