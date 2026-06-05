import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.lightColorScheme,
    primaryColor: AppColors.lightColorScheme.primary,
    scaffoldBackgroundColor: AppColors.lightColorScheme.surface,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.beVietnamPro().fontFamily,
    textTheme: GoogleFonts.beVietnamProTextTheme(ThemeData.light().textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: AppColors.lightColorScheme.onSurface),
      titleTextStyle: TextStyle(color: AppColors.lightColorScheme.onSurface, fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 1.0,
      color: AppColors.lightColorScheme.surface,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.lightColorScheme.onSurfaceVariant,
      ),
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: AppColors.lightColorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: AppColors.lightColorScheme.primary,
          width: 1.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: AppColors.lightColorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightColorScheme.primary,
        foregroundColor: AppColors.lightColorScheme.onPrimary,
        elevation: 0.0,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  );

  static final appTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.darkColorScheme,
    primaryColor: AppColors.darkColorScheme.primary,
    scaffoldBackgroundColor: AppColors.darkColorScheme.background, // Slate 900
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.beVietnamPro().fontFamily,
    textTheme: GoogleFonts.beVietnamProTextTheme(ThemeData.dark().textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: AppColors.darkColorScheme.onSurface),
      titleTextStyle: TextStyle(color: AppColors.darkColorScheme.onSurface, fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 1.0,
      color: AppColors.darkColorScheme.surface,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkColorScheme.primaryContainer,
      contentTextStyle: TextStyle(color: AppColors.darkColorScheme.onPrimaryContainer),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkColorScheme.surface, // Slate 800
      hintStyle: TextStyle(
        color: AppColors.darkColorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: AppColors.darkColorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: AppColors.darkColorScheme.primary,
          width: 1.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: AppColors.darkColorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkColorScheme.primary,
        foregroundColor: AppColors.darkColorScheme.onPrimary,
        elevation: 0.0,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  );
}
