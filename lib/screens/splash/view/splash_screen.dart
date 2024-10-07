import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_management/common/logic/auth_controller.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/assets_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return AppBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsPath.logo,
              width: 140,
            ),
          ],
        ),
      ),
    );
  }
}
