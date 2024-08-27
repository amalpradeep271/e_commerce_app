import 'package:e_commerce_application/data/auth/repository/auth_repository_impl.dart';
import 'package:e_commerce_application/data/auth/source/auth_firebase_service.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/domain/auth/usecase/get_ages.dart';
import 'package:e_commerce_application/domain/auth/usecase/is_logged_in_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/send_password_reset_email_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/signin_usecase.dart';
// import 'package:e_commerce_application/domain/auth/usecase/get_ages.dart';
import 'package:e_commerce_application/domain/auth/usecase/signup_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
//Services

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

//Repositories

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

//Usecases
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetAgesUseCase>(GetAgesUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SendPasswordResetEmailUseCase>(
      SendPasswordResetEmailUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
}
