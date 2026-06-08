import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/user/repository/user_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class UploadUserImageUsecase implements UseCase<Either<String, String>, File> {
  @override
  Future<Either<String, String>> call({File? params}) async {
    return await sl<UserRepository>().uploadProfileImage(params!);
  }
}
