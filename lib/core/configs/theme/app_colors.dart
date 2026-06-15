import 'package:flutter/material.dart';
import 'package:e_commerce_application/core/configs/tenant/tenant_config.dart';

class AppColors {
  AppColors._();

  static Color get kPrimaryColor => TenantConfig.instance.primaryColor;

  static MaterialColor get appPrimarySwatch {
    final primary = kPrimaryColor;
    return MaterialColor(primary.toARGB32(), <int, Color>{
      50: primary.withValues(alpha: 0.1),
      100: primary.withValues(alpha: 0.2),
      200: primary.withValues(alpha: 0.3),
      300: primary.withValues(alpha: 0.4),
      400: primary.withValues(alpha: 0.5),
      500: primary.withValues(alpha: 0.6),
      600: primary.withValues(alpha: 0.7),
      700: primary.withValues(alpha: 0.8),
      800: primary.withValues(alpha: 0.9),
      900: primary.withValues(alpha: 1.0),
    });
  }

  // Material 3 Color Schemes derived from Design System Tokens
  static ColorScheme get lightColorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: TenantConfig.instance.primaryColor,
    onPrimary: const Color(0xFFFFFFFF),
    primaryContainer: TenantConfig.instance.secondaryColor,
    onPrimaryContainer: const Color(0xFFE0D2FF),
    secondary: TenantConfig.instance.secondaryColor,
    onSecondary: const Color(0xFFFFFFFF),
    secondaryContainer: const Color(0xFFE1D4FD),
    onSecondaryContainer: TenantConfig.instance.secondaryColor,
    tertiary: const Color(0xFF765B00),
    onTertiary: const Color(0xFFFFFFFF),
    tertiaryContainer: const Color(0xFFC9A74D),
    onTertiaryContainer: const Color(0xFF503D00),
    error: const Color(0xFFBA1A1A),
    onError: const Color(0xFFFFFFFF),
    errorContainer: const Color(0xFFFFDAD6),
    onErrorContainer: const Color(0xFF93000A),
    background: const Color(0xFFFDF7FF),
    onBackground: const Color(0xFF1D1B20),
    surface: const Color(0xFFFDF7FF),
    onSurface: const Color(0xFF1D1B20),
    surfaceContainerHighest: const Color(0xFFE6E0E9),
    onSurfaceVariant: const Color(0xFF494551),
    outline: const Color(0xFF7A7582),
    outlineVariant: const Color(0xFFCBC4D2),
    inverseSurface: const Color(0xFF322F35),
    onInverseSurface: const Color(0xFFF5EFF7),
    inversePrimary: const Color(0xFFCFBCFF),
  );

  static ColorScheme get darkColorScheme => ColorScheme(
    brightness: Brightness.dark,
    primary: TenantConfig.instance.primaryColor,
    onPrimary: const Color(0xFF381E72),
    primaryContainer: TenantConfig.instance.primaryColor,
    onPrimaryContainer: const Color(0xFFE9DDFF),
    secondary: TenantConfig.instance.secondaryColor,
    onSecondary: const Color(0xFF332D41),
    secondaryContainer: const Color(0xFF4A4458),
    onSurfaceVariant: const Color(0xFFCAC4D0),
    onSecondaryContainer: const Color(0xFFE8DEF8),
    tertiary: const Color(0xFFEFB8C8),
    onTertiary: const Color(0xFF492532),
    tertiaryContainer: const Color(0xFF633B48),
    onTertiaryContainer: const Color(0xFFFFD8E4),
    error: const Color(0xFFFFB4AB),
    onError: const Color(0xFF690005),
    errorContainer: const Color(0xFF93000A),
    onErrorContainer: const Color(0xFFFFDAD6),
    background: const Color(0xFF0F172A), // Slate 900
    onBackground: const Color(0xFFE6E1E5),
    surface: const Color(0xFF1E293B), // Slate 800
    onSurface: const Color(0xFFE6E1E5),
    surfaceContainerHighest: const Color(0xFF49454F),
    outline: const Color(0xFF938F99),
    outlineVariant: const Color(0xFF49454F),
    inverseSurface: const Color(0xFFE6E1E5),
    onInverseSurface: const Color(0xFF313033),
    inversePrimary: const Color(0xFF6750A4),
  );

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color lightblack = Colors.black38;
  static const Color cream = Color(0xFFF0FDFA);
  static const Color lig11htBlack = Color.fromARGB(52, 0, 0, 0);
  static const Color transparent = Color(0x00000000);
  static const Color green = Color(0xFF0D9488);
  static const Color lightgreen = Color(0xFFCCFBF1);
  static const Color red = Color(0xFFEF4444);
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

  // Standardised design colors from screens
  static const Color brandTeal = Color(0xFF14B8A6);
  static const Color brandTealDark = Color(0xFF0D9488);
  static const Color brandTealLightAccent = Color(0xFF006970);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color teal50 = Color(0xFFF0FDFA);

  static const Color green100 = Color(0xFFD1FAE5);
  static const Color green900 = Color(0xFF064E3B);
  static const Color green950 = Color(0xFF022C22);
  static const Color greenSuccess = Color(0xFF10B981);

  // Dynamic context-based helpers
  static Color getPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? brandTeal
        : kPrimaryColor;
  }

  static Color getBrandTeal(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? brandTeal
        : brandTealLightAccent;
  }

  static Color getCardBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? slate800
        : white;
  }

  static Color getScaffoldBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? slate900
        : white;
  }

  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? slate700
        : slate200;
  }

  static LinearGradient get categoryLinercolor => LinearGradient(
    colors: [
      TenantConfig.instance.primaryColor,
      TenantConfig.instance.secondaryColor,
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
  static LinearGradient get navigationBarColor => LinearGradient(
    colors: [
      TenantConfig.instance.primaryColor,
      TenantConfig.instance.secondaryColor,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static LinearGradient get drawerHeaderColor => LinearGradient(
    colors: [
      TenantConfig.instance.primaryColor,
      TenantConfig.instance.secondaryColor,
    ],
    begin: const Alignment(0.70, -0.72),
    end: const Alignment(-0.7, 0.72),
  );
}
