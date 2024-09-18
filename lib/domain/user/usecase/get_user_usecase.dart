import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/user/repository/user_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetUserProfileUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<UserRepository>().getUser();
  }
}