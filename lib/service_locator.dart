import 'package:e_commerce_application/data/auth/repository/auth_repository_impl.dart';
import 'package:e_commerce_application/data/auth/source/auth_firebase_service.dart';
import 'package:e_commerce_application/data/category/repository/category_repository_impl.dart';
import 'package:e_commerce_application/data/category/source/category_firebase_service.dart';
import 'package:e_commerce_application/data/product/repository/product_repository_impl.dart';
import 'package:e_commerce_application/data/product/source/product_firebase_service.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/domain/auth/usecase/get_ages_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/get_user_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/is_logged_in_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/send_password_reset_email_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/signin_usecase.dart';
// import 'package:e_commerce_application/domain/auth/usecase/get_ages.dart';
import 'package:e_commerce_application/domain/auth/usecase/signup_usecase.dart';
import 'package:e_commerce_application/domain/category/repository/category_repository.dart';
import 'package:e_commerce_application/domain/category/usecase/get_category_usecase.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';
import 'package:e_commerce_application/domain/product/usecase/get_newin_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/get_product_by_categoryId.dart';
import 'package:e_commerce_application/domain/product/usecase/get_products_by_title.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
//Services

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<CategoryFireBaseService>(CategoryFireBaseServiceImpl());
  sl.registerSingleton<ProductFirebaseService>(ProductFirebaseServiceImpl());

//Repositories

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());

//Usecases
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetAgesUseCase>(GetAgesUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SendPasswordResetEmailUseCase>(
      SendPasswordResetEmailUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<GetCategoryUseCase>(GetCategoryUseCase());
  sl.registerSingleton<GetTopSellingUseCase>(GetTopSellingUseCase());
  sl.registerSingleton<GetNewInUseCase>(GetNewInUseCase());
  sl.registerSingleton<GetProductsByCategoryIdUseCase>(
      GetProductsByCategoryIdUseCase());
  sl.registerSingleton<GetProductsByTitleUseCase>(GetProductsByTitleUseCase());
}
