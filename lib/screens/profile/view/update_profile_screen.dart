import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/logic/user_details_controller.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/common/widgets/common_app_bar.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/profile/controller/profile_controller.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final UserDetailsController userDetailsController =
      Get.put(UserDetailsController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userDetailsController.getUserDetails();
    profileController.emailController.text =
        userDetailsController.userData["email"].isNotEmpty
            ? userDetailsController.userData["email"]
            : "";
    profileController.firstNameController.text =
        userDetailsController.userData["firstName"].isNotEmpty
            ? userDetailsController.userData["firstName"]
            : "";
    profileController.lastNameController.text =
        userDetailsController.userData["lastName"].isNotEmpty
            ? userDetailsController.userData["lastName"]
            : "";
    profileController.mobileController.text =
        userDetailsController.userData["mobile"].isNotEmpty
            ? userDetailsController.userData["mobile"]
            : "";
    profileController.passwordController.text =
        userDetailsController.userData["password"].isNotEmpty
            ? userDetailsController.userData["password"]
            : "";
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CommonAppBar(),
      body: AppBackground(
        child: Obx(
          () => userDetailsController.isProgress.value
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.colorGreen,
                  ),
                )
              : Padding(
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
                            context, formKey, profileController),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom))
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

Widget _buildProfileUpdateForm(context, GlobalKey<FormState> formKey,
    ProfileController profileController) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        TextFormField(
          controller: profileController.emailController,
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
          controller: profileController.firstNameController,
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
          controller: profileController.lastNameController,
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
          controller: profileController.mobileController,
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
          controller: profileController.passwordController,
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
        Obx(
          () => Visibility(
            visible: !profileController.isProgress.value,
            replacement: const Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.colorGreen,
              ),
            ),
            child: ElevatedButton(
              onPressed: () =>
                  profileController.updateProfile(formKey: formKey),
              child: const Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
