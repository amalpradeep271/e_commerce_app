import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetUserUseCase implements UseCase<Either<String, UserEntity>, dynamic> {
  @override
  Future<Either<String, UserEntity>> call({dynamic params}) async {
    return sl<AuthRepository>().getUser();
  }
}
