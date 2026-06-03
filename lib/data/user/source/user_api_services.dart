import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class UserApiService {
  Future<Either<String, dynamic>> getUser();
  Future<Either<String, String>> uploadProfileImage(File imageFile);
}

class UserApiServiceImpl extends UserApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> getUser() async {
    return _apiClient.getRequest('/users/me');
  }

  @override
  Future<Either<String, String>> uploadProfileImage(File imageFile) async {
    try {
      final imageUrl = await _apiClient.uploadImage('/users/me/avatar', imageFile);
      return Right(imageUrl);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
