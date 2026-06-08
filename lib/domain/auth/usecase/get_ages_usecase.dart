import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetAgesUseCase implements UseCase<Either<String, dynamic>, dynamic> {
  @override
  Future<Either<String, dynamic>> call({dynamic params}) async {
    return sl<AuthRepository>().getAges();
  }
}
