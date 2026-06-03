import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/mapping_helper.dart';
import 'package:e_commerce_application/data/auth/models/user.dart';
import 'package:e_commerce_application/data/user/source/user_api_services.dart';
import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';
import 'package:e_commerce_application/domain/user/repository/user_repository.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either<String, UserEntity>> getUser() async {
    final user = await sl<UserApiService>().getUser();
    return mapResponse<UserEntity>(
      user,
      (data) => UserModel.fromMap(data).toEntity(),
    );
  }

  @override
  Future<Either<String, String>> uploadProfileImage(File imageFile) async {
    final result = await sl<UserApiService>().uploadProfileImage(imageFile);
    result.fold(
      (error) => null,
      (imageUrl) => sl<AuthRepository>().clearUserCache(),
    );
    return result;
  }
}