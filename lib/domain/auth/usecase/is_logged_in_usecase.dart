import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({params})async  {
return await sl<AuthRepository>().isLoggedIn();
  }

}