import 'package:flutter/material.dart';
import 'package:task_management/common/widgets/app_background.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBackground(
        child: Center(
      child: Text("Completed Screen"),
    ));
  }
}
