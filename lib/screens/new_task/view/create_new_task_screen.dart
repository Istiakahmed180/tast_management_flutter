import 'package:flutter/material.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/common/widgets/common_app_bar.dart';

class CreateNewTaskScreen extends StatelessWidget {
  const CreateNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CommonAppBar(),
      body: AppBackground(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              Text(
                "Add New Task",
                style:
                    textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildNewTaskForm(context),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ),
      ),
    );
  }

  Form _buildNewTaskForm(context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: "Subject"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter subject";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            maxLines: 5,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              hintText: "Description",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter description";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add form submission logic here
            },
            child: const Icon(
              Icons.arrow_circle_right_outlined,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
