import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/auth/models/user_creation_req.dart';
import 'package:e_commerce_application/data/auth/models/user_signin_req.dart';
import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, String>> signUp(UserCreationReq user);
  Future<Either<String, String>> signIn(UserSignInReq user);
  Future<Either<String, dynamic>> getAges();
  Future<Either<String, String>> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either<String, UserEntity>> getUser();
  void clearUserCache();
}
