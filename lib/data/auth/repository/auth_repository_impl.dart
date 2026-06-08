import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/mapping_helper.dart';
import 'package:e_commerce_application/data/auth/models/user.dart';
import 'package:e_commerce_application/data/auth/models/user_creation_req.dart';
import 'package:e_commerce_application/data/auth/models/user_signin_req.dart';
import 'package:e_commerce_application/data/auth/source/auth_api_service.dart';
import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<String, String>> signUp(UserCreationReq user) async {
    return sl<AuthApiService>().signUp(user);
  }

  @override
  Future<Either<String, dynamic>> getAges() async {
    return await sl<AuthApiService>().getAges();
  }

  @override
  Future<Either<String, String>> signIn(UserSignInReq user) async {
    return await sl<AuthApiService>().signIn(user);
  }

  @override
  Future<Either<String, String>> sendPasswordResetEmail(String email) async {
    return await sl<AuthApiService>().sendPasswordResetEmail(email);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthApiService>().isLoggedIn();
  }

  UserEntity? _cachedUser;

  @override
  void clearUserCache() {
    _cachedUser = null;
  }

  @override
  Future<Either<String, UserEntity>> getUser() async {
    if (_cachedUser != null) {
      return Right(_cachedUser!);
    }
    final user = await sl<AuthApiService>().getUser();
    final result = mapResponse<UserEntity>(
      user,
      (data) => UserModel.fromMap(data).toEntity(),
    );
    result.fold(
      (error) => null,
      (data) => _cachedUser = data,
    );
    return result;
  }
}
