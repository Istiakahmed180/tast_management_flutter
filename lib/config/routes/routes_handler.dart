import 'package:flutter/material.dart';
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/config/routes/routes_config.dart';

Map<String, WidgetBuilder> routesHandler() {
  return {
    Routes.splash: (context) => RoutesConfig.splashScreen,
    Routes.signIn: (context) => RoutesConfig.signInScreen,
    Routes.signUp: (context) => RoutesConfig.signUpScreen
  };
}
