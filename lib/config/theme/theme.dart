import 'package:flutter/material.dart';
import 'package:task_management/constants/app_colors.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      textTheme: TextTheme(
        displaySmall: _displaySmallTextStyle(),
      ),
      inputDecorationTheme: _inputDecorationTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        hintStyle: const TextStyle(color: Colors.grey),
        border: _outlineInputBorder(),
        enabledBorder: _outlineInputBorder(),
        errorBorder: _outlineInputBorder(),
        focusedBorder: _outlineInputBorder());
  }

  static OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8));
  }

  static TextStyle _displaySmallTextStyle() {
    return const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w500,
    );
  }
}
