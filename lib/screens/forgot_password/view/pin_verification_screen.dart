import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/forgot_password/controller/forgot_password_controller.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String currentText = "";
  bool hasError = false;
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

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
                  "Pin Verification",
                  style: textTheme.displaySmall,
                ),
                const SizedBox(height: 20),
                Text(
                  "A 6 digit verification pin will be sent to your email address",
                  style: textTheme.titleSmall,
                ),
                const SizedBox(height: 24),
                _buildPinCodeVerify(),
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      _buildSignInSection(),
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

  Widget _buildPinCodeVerify() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          PinCodeTextField(
            controller: textEditingController,
            backgroundColor: Colors.transparent,
            appContext: context,
            length: 6,
            cursorColor: AppColors.colorLightGray,
            validator: (v) {
              if (v!.length < 6) {
                return "Please enter a valid 6 digit pin";
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 40,
                activeColor: AppColors.colorWhite,
                inactiveColor: AppColors.colorGreen,
                inactiveFillColor: AppColors.colorWhite),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                currentText = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () =>
                onTapPinVerifyActionVerifyAction(context, formKey, currentText),
            child: const Text(
              "Verify",
            ),
          ),
        ],
      ),
    );
  }

  RichText _buildSignInSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5),
        text: "Have an account? ",
        children: [
          TextSpan(
              text: 'Sign In',
              style: const TextStyle(color: AppColors.colorGreen),
              recognizer: TapGestureRecognizer()
                ..onTap = () => onTapPinVerificationSignInAction(context)),
        ],
      ),
    );
  }
}
