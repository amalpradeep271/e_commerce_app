import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/auth/models/user.dart';
import 'package:e_commerce_application/data/user/source/user_firebase_services.dart';
import 'package:e_commerce_application/domain/user/repository/user_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either> getUser() async {
      var user = await sl<UserFirebaseService>().getUser();
        return user.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          UserModel.fromMap(data).toEntity(),
        );
      },
    );
  }
}