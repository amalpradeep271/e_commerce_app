import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../network/api_client.dart';
import 'tenant_config.dart';

class TenantConfigService {
  static const _storage = FlutterSecureStorage();
  static const _configCacheKey = 'tenant_config_cache';

  static Future<void> initialize(String slug) async {
    // 1. First, attempt to load cached config from secure storage for immediate offline/fast startup
    try {
      final cachedJson = await _storage.read(key: _configCacheKey);
      if (cachedJson != null) {
        final decoded = json.decode(cachedJson) as Map<String, dynamic>;
        // Verify it matches the requested slug before applying
        if (decoded['slug'] == slug) {
          TenantConfig.instance = TenantConfig.fromJson(decoded);
          debugPrint('TenantConfig loaded from local cache for slug: $slug');
        }
      }
    } catch (e) {
      debugPrint('Error loading cached tenant config: $e');
    }

    // 2. Fetch fresh config from API on boot
    try {
      final baseUrl = ApiClient.baseUrl;
      final response = await http.get(
        Uri.parse('$baseUrl/tenants/$slug/config'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final newConfig = TenantConfig.fromJson(data);
        TenantConfig.instance = newConfig;

        // Save to cache
        await _storage.write(
          key: _configCacheKey,
          value: json.encode(newConfig.toJson()),
        );
        debugPrint('TenantConfig loaded from API and cached for slug: $slug');
      } else {
        debugPrint('Failed to load tenant config from API: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Network error loading tenant config from API: $e');
    }
  }
}
