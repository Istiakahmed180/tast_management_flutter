import 'package:flutter/material.dart';
import 'package:task_management/common/widgets/app_background.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBackground(
        child: Center(
      child: Text("Progress Screen"),
    ));
  }
}
