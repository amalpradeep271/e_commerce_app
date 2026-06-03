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
  static const String _tokenKey = 'jwt_token';

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await getToken();
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
    final headers = await _getHeaders();
    return await http.get(url, headers: headers);
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$path');
    final headers = await _getHeaders();
    return await http.post(url, headers: headers, body: json.encode(body));
  }

  Future<http.Response> delete(String path) async {
    final url = Uri.parse('$baseUrl$path');
    final headers = await _getHeaders();
    return await http.delete(url, headers: headers);
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
    final token = await getToken();
    
    final request = http.MultipartRequest('POST', url);
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    
    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );
    
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['imageUrl'] as String;
    } else {
      throw Exception('Failed to upload image: ${response.body}');
    }
  }
}
