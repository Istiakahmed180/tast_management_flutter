import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/sign_up/controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                const SizedBox(height: 100),
                Text(
                  "Join With Us",
                  style: textTheme.displaySmall,
                ),
                const SizedBox(height: 24),
                _buildSignUpForm(),
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      _buildSignInSection(context),
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
}

RichText _buildSignInSection(context) {
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
              ..onTap = () => onTapSignIn(context)),
      ],
    ),
  );
}

Form _buildSignUpForm() {
  return Form(
    child: Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "Email"),
        ),
        const SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "First Name"),
        ),
        const SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "Last Name"),
        ),
        const SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: "Mobile"),
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
