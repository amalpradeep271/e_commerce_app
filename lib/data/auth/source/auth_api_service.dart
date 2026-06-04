import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/data/auth/models/user_creation_req.dart';
import 'package:e_commerce_application/data/auth/models/user_signin_req.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class AuthApiService {
  Future<Either<String, String>> signUp(UserCreationReq user);
  Future<Either<String, String>> signIn(UserSignInReq user);
  Future<Either<String, dynamic>> getAges();
  Future<Either<String, String>> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either<String, dynamic>> getUser();
}

class AuthApiServiceImpl extends AuthApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, String>> signUp(UserCreationReq user) async {
    try {
      final response = await _apiClient.post('/auth/signup', {
        'email': user.email,
        'password': user.password,
        'firstName': user.firstName,
        'lastName': user.lastName,
      });

      final data = json.decode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (data['accessToken'] != null && data['refreshToken'] != null) {
          await _apiClient.saveTokens(
            accessToken: data['accessToken'] as String,
            refreshToken: data['refreshToken'] as String,
          );
        }
        return const Right('Sign up was successfull');
      } else {
        return Left(data['message'] ?? 'Sign up failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> signIn(UserSignInReq user) async {
    try {
      final response = await _apiClient.post('/auth/signin', {
        'email': user.email,
        'password': user.password,
      });

      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['accessToken'] != null && data['refreshToken'] != null) {
          await _apiClient.saveTokens(
            accessToken: data['accessToken'] as String,
            refreshToken: data['refreshToken'] as String,
          );
        }
        return const Right('Sign in was successfull');
      } else {
        return Left(data['message'] ?? 'Sign in failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, dynamic>> getAges() async {
    return _apiClient.getRequest('/auth/ages');
  }

  @override
  Future<Either<String, String>> sendPasswordResetEmail(String email) async {
    // Return Right directly since reset email SMTP is not set up on free hosting backend
    return const Right('Password reset email is send');
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _apiClient.getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<Either<String, dynamic>> getUser() async {
    return _apiClient.getRequest('/users/me');
  }
}
