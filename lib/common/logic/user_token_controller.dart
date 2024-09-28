import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTokenController extends GetxController {
  var userToken = RxnString();

  @override
  void onInit() {
    super.onInit();
    getUserToken();
  }

  Future<void> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken.value = prefs.getString("user_token");
  }
}
