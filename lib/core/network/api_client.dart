import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dartz/dartz.dart';

class ApiClient {
  // Use localhost for Windows/Web/iOS Simulator, 10.0.2.2 for Android Emulator, or update to your Render.com URL
  static final String baseUrl = _getBaseUrl();

  static String _getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:3000/v1';
    }
    // Use your PC's local network IP so it works on both physical devices (over Wi-Fi) and emulators.
    return 'http://192.168.1.11:3000/v1';
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  Future<String?> getToken() async {
    return await getAccessToken();
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<void> clearToken() async {
    await clearTokens();
  }

  bool _isRefreshing = false;

  Future<bool> refreshAccessToken() async {
    if (_isRefreshing) {
      return false;
    }
    _isRefreshing = true;
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        _isRefreshing = false;
        return false;
      }

      final url = Uri.parse('$baseUrl/auth/refresh');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['accessToken'] != null && data['refreshToken'] != null) {
          await saveTokens(
            accessToken: data['accessToken'],
            refreshToken: data['refreshToken'],
          );
          _isRefreshing = false;
          return true;
        }
      }

      await clearTokens();
      _isRefreshing = false;
      return false;
    } catch (e) {
      debugPrint('ApiClient Refresh Token Error: $e');
      _isRefreshing = false;
      return false;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await getAccessToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<http.Response> get(String path) async {
    final url = Uri.parse('$baseUrl$path');
    var headers = await _getHeaders();
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 401) {
      final success = await refreshAccessToken();
      if (success) {
        headers = await _getHeaders();
        response = await http.get(url, headers: headers);
      }
    }
    return response;
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$path');
    var headers = await _getHeaders();
    var response = await http.post(url, headers: headers, body: json.encode(body));

    if (response.statusCode == 401) {
      final success = await refreshAccessToken();
      if (success) {
        headers = await _getHeaders();
        response = await http.post(url, headers: headers, body: json.encode(body));
      }
    }
    return response;
  }

  Future<http.Response> delete(String path) async {
    final url = Uri.parse('$baseUrl$path');
    var headers = await _getHeaders();
    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 401) {
      final success = await refreshAccessToken();
      if (success) {
        headers = await _getHeaders();
        response = await http.delete(url, headers: headers);
      }
    }
    return response;
  }

  Future<Either<String, dynamic>> getRequest(String path) async {
    try {
      final response = await get(path);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(data);
      } else {
        final message = (data is Map && data['message'] != null)
            ? data['message'].toString()
            : 'Please try again';
        return Left(message);
      }
    } catch (e) {
      debugPrint('ApiClient GET Error on path $path: $e');
      return const Left('Please try again');
    }
  }

  Future<Either<String, dynamic>> postRequest(String path, Map<String, dynamic> body) async {
    try {
      final response = await post(path, body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(data);
      } else {
        final message = (data is Map && data['message'] != null)
            ? data['message'].toString()
            : 'Please try again';
        return Left(message);
      }
    } catch (e) {
      debugPrint('ApiClient POST Error on path $path: $e');
      return const Left('Please try again');
    }
  }

  Future<Either<String, dynamic>> deleteRequest(String path) async {
    try {
      final response = await delete(path);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(data);
      } else {
        final message = (data is Map && data['message'] != null)
            ? data['message'].toString()
            : 'Please try again';
        return Left(message);
      }
    } catch (e) {
      debugPrint('ApiClient DELETE Error on path $path: $e');
      return const Left('Please try again');
    }
  }

  Future<String> uploadImage(String path, File imageFile) async {
    final url = Uri.parse('$baseUrl$path');
    var token = await getAccessToken();

    var request = http.MultipartRequest('POST', url);
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 401) {
      final success = await refreshAccessToken();
      if (success) {
        token = await getAccessToken();
        request = http.MultipartRequest('POST', url);
        if (token != null) {
          request.headers['Authorization'] = 'Bearer $token';
        }
        request.files.add(
          await http.MultipartFile.fromPath('file', imageFile.path),
        );
        streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      }
    }

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['imageUrl'] as String;
    } else {
      throw Exception('Failed to upload image: ${response.body}');
    }
  }
}
