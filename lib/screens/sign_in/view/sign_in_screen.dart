import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/constants/api_path.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/helpers/helper_snackbar.dart';
import 'package:task_management/network/network_response.dart';
import 'package:task_management/network/network_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              controller: emailController,
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
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter password";
                }
                return null;
              }),
          const SizedBox(height: 20),
          isLoading
              ? const CircularProgressIndicator(
                  backgroundColor: AppColors.colorGreen,
                )
              : ElevatedButton(
                  onPressed: () => userSignIn(),
                  child: const Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 30,
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> userSignIn() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final Map<String, dynamic> requestBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      final NetworkResponse networkResponse = await NetworkService.postRequest(
          url: ApiPath.login, requestBody: requestBody);

      if (networkResponse.isSuccess) {
        if (networkResponse.requestResponse["status"] == "success") {
          final token = networkResponse.requestResponse["token"];
          if (token != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("token", token);
            HelperSnackbar.showSnackBar(
                context: context, message: "Login Success");
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (route) => false,
            );
            setState(() {
              isLoading = false;
            });
          }
        } else if (networkResponse.requestResponse["status"] == "fail") {
          HelperSnackbar.showSnackBar(
              context: context,
              message: networkResponse.requestResponse["data"],
              backgroundColor: AppColors.colorRed);
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }
}
