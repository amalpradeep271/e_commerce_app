import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<String, UserEntity>> getUser();
  Future<Either<String, String>> uploadProfileImage(File imageFile);
}
