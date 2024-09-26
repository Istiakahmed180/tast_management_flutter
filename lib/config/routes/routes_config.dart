import 'package:task_management/screens/forgot_password/view/email_address_screen.dart';
import 'package:task_management/screens/forgot_password/view/pin_verification_screen.dart';
import 'package:task_management/screens/forgot_password/view/set_password_screen.dart';
import 'package:task_management/screens/sign_in/view/sign_in_screen.dart';
import 'package:task_management/screens/sign_up/view/sign_up_screen.dart';
import 'package:task_management/screens/splash/view/splash_screen.dart';

class RoutesConfig {
  static const splashScreen = SplashScreen();
  static const signInScreen = SignInScreen();
  static const signUpScreen = SignUpScreen();
  static const emailAddressScreen = EmailAddressScreen();
  static const pinVerificationScreen = PinVerificationScreen();
  static const setPasswordScreen = SetPasswordScreen();
}
