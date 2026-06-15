import 'package:flutter/material.dart';

class TenantConfig {
  static TenantConfig? _instance;
  
  static TenantConfig get instance {
    if (_instance == null) {
      // Return a default configuration (fallback to Khadi)
      return TenantConfig(
        tenantSlug: 'khadi',
        appName: 'Khadi Irinjalakuda',
        tagline: 'Premium E-Commerce Experience',
        logoUrl: 'https://res.cloudinary.com/dbm13lsc5/image/upload/v1717833076/khadi_logo.png', // Fallback default URL
        primaryColor: const Color(0xFF4F378A),
        secondaryColor: const Color(0xFF6750A4),
        fontFamily: 'beVietnamPro',
        currency: 'INR',
        currencySymbol: '₹',
      );
    }
    return _instance!;
  }

  static set instance(TenantConfig config) {
    _instance = config;
  }

  final String tenantSlug;
  final String appName;
  final String tagline;
  final String logoUrl;
  final Color primaryColor;
  final Color secondaryColor;
  final String fontFamily;
  final String currency;
  final String currencySymbol;

  TenantConfig({
    required this.tenantSlug,
    required this.appName,
    required this.tagline,
    required this.logoUrl,
    required this.primaryColor,
    required this.secondaryColor,
    required this.fontFamily,
    required this.currency,
    required this.currencySymbol,
  });

  factory TenantConfig.fromJson(Map<String, dynamic> json) {
    return TenantConfig(
      tenantSlug: json['slug'] ?? 'khadi',
      appName: json['name'] ?? 'Khadi Irinjalakuda',
      tagline: json['tagline'] ?? 'Premium E-Commerce Experience',
      logoUrl: json['logoUrl'] ?? '',
      primaryColor: parseHexColor(json['primaryColor'] ?? '#4F378A'),
      secondaryColor: parseHexColor(json['secondaryColor'] ?? '#6750A4'),
      fontFamily: json['fontFamily'] ?? 'beVietnamPro',
      currency: json['currency'] ?? 'INR',
      currencySymbol: json['currencySymbol'] ?? '₹',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': tenantSlug,
      'name': appName,
      'tagline': tagline,
      'logoUrl': logoUrl,
      'primaryColor': colorToHex(primaryColor),
      'secondaryColor': colorToHex(secondaryColor),
      'fontFamily': fontFamily,
      'currency': currency,
      'currencySymbol': currencySymbol,
    };
  }

  static Color parseHexColor(String hex) {
    try {
      var hexColor = hex.replaceAll('#', '');
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      return const Color(0xFF4F378A);
    }
  }

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }
}
