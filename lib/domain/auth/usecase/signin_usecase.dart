import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/data/auth/models/user_signin_req.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class SignInUseCase implements UseCase<Either<String, String>, UserSignInReq> {
  @override
  Future<Either<String, String>> call({UserSignInReq? params}) async {
    return sl<AuthRepository>().signIn(params!);
  }
}
