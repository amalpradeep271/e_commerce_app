import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color kPrimaryColor = Color(0xFF0F766E);

  static MaterialColor appPrimarySwatch =
      MaterialColor(kPrimaryColor.toARGB32(), <int, Color>{
    50: kPrimaryColor.withValues(alpha: 0.1),
    100: kPrimaryColor.withValues(alpha: 0.2),
    200: kPrimaryColor.withValues(alpha: 0.3),
    300: kPrimaryColor.withValues(alpha: 0.4),
    400: kPrimaryColor.withValues(alpha: 0.5),
    500: kPrimaryColor.withValues(alpha: 0.6),
    600: kPrimaryColor.withValues(alpha: 0.7),
    700: kPrimaryColor.withValues(alpha: 0.8),
    800: kPrimaryColor.withValues(alpha: 0.9),
    900: kPrimaryColor.withValues(alpha: 1.0),
  });

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color lightblack = Colors.black38;
  static const Color cream = Color(0xFFF0FDFA); // Soft mint/teal cream
  static const Color lig11htBlack = Color.fromARGB(52, 0, 0, 0);
  static const Color transparent = Color(0x00000000);
  static const Color green = Color(0xFF0D9488); // Teal green
  static const Color lightgreen = Color(0xFFCCFBF1); // Light teal tint
  static const Color red = Color(0xFFEF4444); // Premium soft red
  static const Color grey = Color(0xFFAAAAAA);
  static const Color lightGray = Color(0xFF909296);
  static const Color orange = Color(0xFFE5951F);
  static const Color productGray = Color.fromARGB(255, 243, 244, 246);
  static const Color accountblue = Color(0xFF0D9488);
  static const Color colorDivider = Color(0xFFE5E7EB);
  static const Color blueAccent = Color(0xFF06B6D4);
  static const Color neutral6 = Color(0xFFF3F4F6);
  static Color neutral3 = const Color(0xFFFFFFFF).withAlpha(51);
  static Color whiteGrey = const Color(0xFFAFA8A8);
  static const Color lightBlue = Color(0xFF0E7490);
  static const Color pink = Color(0xFFFCE7F3);
  static Color appDividerColor = Colors.grey.shade200;

  static const LinearGradient categoryLinercolor = LinearGradient(
    colors: [
      Color(0xFF0F766E),
      Color(0xFF14B8A6),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
  static const LinearGradient navigationBarColor = LinearGradient(
    colors: [
      Color(0xFF0F766E), 
      Color(0xFF0D9488), 
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient drawerHeaderColor = LinearGradient(
    colors: [Color(0xFF0F766E), Color(0xFF115E59)],
    begin: Alignment(0.70, -0.72),
    end: Alignment(-0.7, 0.72),
  );
}
