import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color kPrimaryColor = Color(0xFFE5951F);

  static MaterialColor appPrimarySwatch =
      MaterialColor(kPrimaryColor.value, <int, Color>{
    50: kPrimaryColor.withOpacity(0.1),
    100: kPrimaryColor.withOpacity(0.2),
    200: kPrimaryColor.withOpacity(0.3),
    300: kPrimaryColor.withOpacity(0.4),
    400: kPrimaryColor.withOpacity(0.5),
    500: kPrimaryColor.withOpacity(0.6),
    600: kPrimaryColor.withOpacity(0.7),
    700: kPrimaryColor.withOpacity(0.8),
    800: kPrimaryColor.withOpacity(0.9),
    900: kPrimaryColor.withOpacity(1.0),
  });

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color lightblack = Colors.black38;
  static const Color cream = Color(0xFFFFF3E1);
  static const Color lig11htBlack = Color.fromARGB(52, 0, 0, 0);
  static const Color transparent = Color(0x00000000);
  static const Color green = Color(0xFF05A10C);
  static const Color lightgreen = Color(0xFFE1ED54);
  static const Color red = Color(0xFFFF0000);
  static const Color grey = Color(0xFFAAAAAA);
  static const Color lightGray = Color(0xFF909296);
  static const Color orange = Color(0xFFE5951F);
  static const Color productGray = Color.fromARGB(255, 236, 235, 235);
  static const Color accountblue = Color.fromARGB(255, 36, 152, 238);
  static const Color colorDivider = Color(0xFFEBEBEB);
  static const Color blueAccent = Color(0xF427ACF8);
  static const Color neutral6 = Color(0xFFF1F2F9);
  static Color neutral3 = const Color(0xFFFFFFFF).withAlpha(51);
  static Color whiteGrey = const Color(0xFFAFA8A8);
  static const Color lightBlue = Color(0xFF407DF2);
  static const Color pink = Color.fromARGB(255, 253, 223, 237);
  static  Color appDividerColor=Colors.grey.shade300;

  static const LinearGradient categoryLinercolor = LinearGradient(
    colors: [
      Color(0xFFEBAA4B),
      Color(0xFFE59860),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
  static const LinearGradient navigationBarColor = LinearGradient(
    colors: [
      Color(0xFFE5951F), // #407DF2
      Color(0xFFE59860), // #00246A
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
