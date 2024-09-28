import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/sign_up/controller/sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  void dispose() {
    super.dispose();
    signUpController.emailController.dispose();
    signUpController.firstNameController.dispose();
    signUpController.lastNameController.dispose();
    signUpController.mobileController.dispose();
    signUpController.passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBackground(
      child: Obx(
        () => signUpController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.colorGreen,
              ))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 100),
                          Text(
                            "Join With Us",
                            style: textTheme.displaySmall,
                          ),
                          const SizedBox(height: 24),
                          _buildSignUpForm(context, signUpController),
                          const SizedBox(height: 40),
                          Center(
                            child: Column(
                              children: [
                                _buildSignInSection(context, signUpController),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  RichText _buildSignInSection(context, SignUpController signUpController) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5),
        text: "Have account? ",
        children: [
          TextSpan(
              text: 'Sign In',
              style: const TextStyle(color: AppColors.colorGreen),
              recognizer: TapGestureRecognizer()
                ..onTap = () => signUpController.onTapSignIn(context)),
        ],
      ),
    );
  }

  Widget _buildSignUpForm(context, SignUpController signUpController) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: signUpController.emailController,
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
            controller: signUpController.firstNameController,
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
            controller: signUpController.lastNameController,
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
            controller: signUpController.mobileController,
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
            controller: signUpController.passwordController,
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
            onPressed: () {
              if (formKey.currentState!.validate()) {
                signUpController.onTapSignUpAction(context);
              }
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
