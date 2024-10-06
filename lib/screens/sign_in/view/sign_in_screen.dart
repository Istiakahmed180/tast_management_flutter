import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/sign_in/controller/sign_in_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBackground(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              Text(
                "Get Started With",
                style: textTheme.displaySmall,
              ),
              const SizedBox(height: 24),
              _buildSignInForm(context),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    _buildSignUpSection(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  RichText _buildSignUpSection(context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5),
        text: "Don't have an account? ",
        children: [
          TextSpan(
              text: 'Sign Up',
              style: const TextStyle(color: AppColors.colorGreen),
              recognizer: TapGestureRecognizer()..onTap = () {}),
        ],
      ),
    );
  }

  Form _buildSignInForm(context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
              controller: signInController.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter email address";
                }
                return null;
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: signInController.passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter password";
                }
                return null;
              }),
          const SizedBox(height: 20),
          Obx(
            () => Visibility(
              visible: !signInController.isProgress.value,
              replacement: const CircularProgressIndicator(
                backgroundColor: AppColors.colorGreen,
              ),
              child: ElevatedButton(
                onPressed: () => signInController.signIn(),
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
}
