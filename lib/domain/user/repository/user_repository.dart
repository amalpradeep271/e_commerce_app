import 'dart:io';

import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either> getUser();
  Future<Either<String, String>> uploadProfileImage(File imageFile);
}
