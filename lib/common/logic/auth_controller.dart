import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/config/routes/routes.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    _checkToken();
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      bool isExpired = JwtDecoder.isExpired(token);
      if (!isExpired) {
        isLoggedIn.value = true;
      } else {
        isLoggedIn.value = false;
        _removeToken();
      }
    } else {
      isLoggedIn.value = false;
    }

    _handleNavigation();
  }

  Future<void> _removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  void _handleNavigation() {
    if (isLoggedIn.value) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.signIn);
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  void logout() async {
    await _removeToken();
    isLoggedIn.value = false;
    Get.offAllNamed(Routes.signIn);
  }
}
