import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class SendPasswordResetEmailUseCase implements UseCase<Either<String, String>, String> {
  @override
  Future<Either<String, String>> call({String? params}) async {
    return sl<AuthRepository>().sendPasswordResetEmail(params!);
  }
}
