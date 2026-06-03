import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/data/auth/models/user_creation_req.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class SignUpUseCase implements UseCase<Either<String, String>, UserCreationReq> {
  @override
  Future<Either<String, String>> call({UserCreationReq? params}) async {
    return sl<AuthRepository>().signUp(params!);
  }
}
