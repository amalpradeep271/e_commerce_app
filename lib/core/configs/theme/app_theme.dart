import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: 'OpenSans_Condensed',
    //  inputDecorationTheme: InputDecorationTheme(
    //   hintStyle: const TextStyle(
    //     fontWeight: FontWeight.w500,
    //     color: AppColors.hintTextColor,
    //   ),
    //   filled: true,
    //   fillColor: AppColors.transparent,
    //   contentPadding: const EdgeInsets.all(20),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(25),
    //     borderSide: const BorderSide(
    //       color: AppColors.black,
    //       width: 0.2,
    //     ),
    //   ),
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(25),
    //     borderSide: const BorderSide(
    //       color: AppColors.black,
    //       width: 0.2,
    //     ),
    //   ),
    // ),
  );
  static final appTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.dark,
    fontFamily: 'OpenSans_Condensed',
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.background,
      contentTextStyle: TextStyle(color: AppColors.whiteColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.secondBackground,
      hintStyle: const TextStyle(
        color: AppColors.greyColor,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    ),
  );
}
