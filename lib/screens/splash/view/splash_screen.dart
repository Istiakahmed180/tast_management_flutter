import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/assets_path.dart';
import 'package:task_management/screens/splash/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsPath.logo,
            width: 140,
          )
        ],
      ),
    ));
  }
}
