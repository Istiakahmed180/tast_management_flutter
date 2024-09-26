import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/sign_in/controller/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
                  "Get Started With",
                  style: textTheme.displaySmall,
                ),
                const SizedBox(height: 24),
                _buildSignInForm(),
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () => onTapForgotPassword(context),
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
              recognizer: TapGestureRecognizer()
                ..onTap = () => onTapSignUp(context)),
        ],
      ),
    );
  }

  Form _buildSignInForm() {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onTapNextButton,
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
