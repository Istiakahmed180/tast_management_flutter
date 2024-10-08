import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTokenController extends GetxController {
  static const String _tokenKey = 'token';
  final token = RxnString(null);

  @override
  void onInit() {
    getUserToken();
    super.onInit();
  }

  Future<void> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString(_tokenKey);
  }
}
