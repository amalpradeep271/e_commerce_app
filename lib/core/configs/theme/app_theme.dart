import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce_application/core/configs/tenant/tenant_config.dart';
import 'app_colors.dart';

String? _getFontFamily(String slug) {
  switch (slug.toLowerCase()) {
    case 'roboto':
      return GoogleFonts.roboto().fontFamily;
    case 'inter':
      return GoogleFonts.inter().fontFamily;
    case 'poppins':
      return GoogleFonts.poppins().fontFamily;
    case 'outfit':
      return GoogleFonts.outfit().fontFamily;
    case 'bevietnampro':
    default:
      return GoogleFonts.beVietnamPro().fontFamily;
  }
}

TextTheme _getFontTextTheme(String slug, TextTheme baseTheme) {
  switch (slug.toLowerCase()) {
    case 'roboto':
      return GoogleFonts.robotoTextTheme(baseTheme);
    case 'inter':
      return GoogleFonts.interTextTheme(baseTheme);
    case 'poppins':
      return GoogleFonts.poppinsTextTheme(baseTheme);
    case 'outfit':
      return GoogleFonts.outfitTextTheme(baseTheme);
    case 'bevietnampro':
    default:
      return GoogleFonts.beVietnamProTextTheme(baseTheme);
  }
}

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.lightColorScheme,
    primaryColor: AppColors.lightColorScheme.primary,
    scaffoldBackgroundColor: AppColors.lightColorScheme.surface,
    brightness: Brightness.light,
    fontFamily: _getFontFamily(TenantConfig.instance.fontFamily),
    textTheme: _getFontTextTheme(TenantConfig.instance.fontFamily, ThemeData.light().textTheme),
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

  static ThemeData get appTheme => ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.darkColorScheme,
    primaryColor: AppColors.darkColorScheme.primary,
    scaffoldBackgroundColor: AppColors.darkColorScheme.background, // Slate 900
    brightness: Brightness.dark,
    fontFamily: _getFontFamily(TenantConfig.instance.fontFamily),
    textTheme: _getFontTextTheme(TenantConfig.instance.fontFamily, ThemeData.dark().textTheme),
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
