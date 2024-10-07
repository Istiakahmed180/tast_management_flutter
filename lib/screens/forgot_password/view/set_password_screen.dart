import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/forgot_password/controller/forgot_password_controller.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordSetPasswordController setPasswordController =
        Get.put(ForgotPasswordSetPasswordController());
    TextTheme textTheme = Theme.of(context).textTheme;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return AppBackground(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150),
                Text(
                  "Set Password",
                  style: textTheme.displaySmall,
                ),
                const SizedBox(height: 20),
                Text(
                  "Minimum length password 8 character with latter and number combination",
                  style: textTheme.titleSmall,
                ),
                const SizedBox(height: 24),
                _buildPasswordAndConfirmPasswordForm(
                    context, formKey, setPasswordController),
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      _buildSignInSection(context, setPasswordController),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _buildPasswordAndConfirmPasswordForm(
      context,
      GlobalKey<FormState> formKey,
      ForgotPasswordSetPasswordController setPasswordController) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: setPasswordController.passwordController,
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
          TextFormField(
            controller: setPasswordController.confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Confirm Password"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter confirm password";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Obx(
            () => Visibility(
              visible: !setPasswordController.isProgress.value,
              replacement: const CircularProgressIndicator(
                backgroundColor: AppColors.colorGreen,
              ),
              child: ElevatedButton(
                onPressed: () =>
                    setPasswordController.setPassword(formKey: formKey),
                child: const Text("Confirm"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  RichText _buildSignInSection(
      context, ForgotPasswordSetPasswordController setPasswordController) {
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
                ..onTap = () => setPasswordController.goToSignIn()),
        ],
      ),
    );
  }
}
