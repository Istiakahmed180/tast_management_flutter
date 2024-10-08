import 'package:flutter/material.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/common/widgets/common_app_bar.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CommonAppBar(),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Update Profile",
                  style: textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                _buildProfileUpdateForm(
                  context,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildProfileUpdateForm(
  context,
) {
  return Form(
    child: Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "Email"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter email address";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "First Name"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter first name";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "Last Name"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter last name";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: "Mobile"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter mobile number";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(hintText: "Password"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter password";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: const Icon(
            Icons.arrow_circle_right_outlined,
            size: 30,
          ),
        ),
      ],
    ),
  );
}
