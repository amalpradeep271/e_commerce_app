import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/data/auth/repository/auth_repository_impl.dart';
import 'package:e_commerce_application/data/auth/source/auth_firebase_service.dart';
import 'package:e_commerce_application/data/cart/repository/cart_repository_impl.dart';
import 'package:e_commerce_application/data/cart/source/cart_firebase_services.dart';
import 'package:e_commerce_application/data/category/repository/category_repository_impl.dart';
import 'package:e_commerce_application/data/category/source/category_firebase_service.dart';
import 'package:e_commerce_application/data/home/repository/banner_repository_impl.dart';
import 'package:e_commerce_application/data/home/source/banner_firebase_service.dart';
import 'package:e_commerce_application/data/order/repository/order_repository_impl.dart';
import 'package:e_commerce_application/data/order/source/order_firebase_service.dart';
import 'package:e_commerce_application/data/product/repository/product_repository_impl.dart';
import 'package:e_commerce_application/data/product/source/product_firebase_service.dart';
import 'package:e_commerce_application/data/review/repository/review_repository_impl.dart';
import 'package:e_commerce_application/data/review/source/review_firebase_services.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/domain/auth/usecase/get_ages_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/get_user_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/is_logged_in_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/send_password_reset_email_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/signin_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/signup_usecase.dart';
import 'package:e_commerce_application/domain/cart/repository/cart_repository.dart';
import 'package:e_commerce_application/domain/category/repository/category_repository.dart';
import 'package:e_commerce_application/domain/category/usecase/get_category_usecase.dart';
import 'package:e_commerce_application/domain/home/repository/banner_repository.dart';
import 'package:e_commerce_application/domain/home/usecase/get_banners_usecase.dart';
import 'package:e_commerce_application/domain/order/repository/order_repository.dart';
import 'package:e_commerce_application/domain/cart/usecase/add_to_cart_usecase.dart';
import 'package:e_commerce_application/domain/cart/usecase/get_cart_products_usecase.dart';
import 'package:e_commerce_application/domain/order/usecase/get_orders_usecase.dart';
import 'package:e_commerce_application/domain/order/usecase/order_registration_usecase.dart';
import 'package:e_commerce_application/domain/cart/usecase/remove_cart_products_usecase.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';
import 'package:e_commerce_application/domain/product/usecase/add_or_remove_favourite_product_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/get_favourite_products_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/get_newin_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/get_product_by_category_id.dart';
import 'package:e_commerce_application/domain/product/usecase/get_products_by_title.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/is_favourite_usecase.dart';
import 'package:e_commerce_application/domain/review/repository/review_repository.dart';
import 'package:e_commerce_application/domain/review/usecase/add_to_review_usecase.dart';
import 'package:e_commerce_application/domain/review/usecase/get_review_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
//Services

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<BannerFirebaseService>(BannerFirebaseServiceImpl());
  sl.registerSingleton<CategoryFireBaseService>(CategoryFireBaseServiceImpl());
  sl.registerSingleton<ProductFirebaseService>(ProductFirebaseServiceImpl());
  sl.registerSingleton<CartFirebaseServices>(CartFirebaseServicesImpl());
  sl.registerSingleton<OrderFirebaseService>(OrderFirebaseServiceImpl());
  sl.registerSingleton<ReviewFirebaseService>(ReviewFirebaseServiceImpl());

//Repositories

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<BannerRepository>(BannerRepositoryImpl());
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());
  sl.registerSingleton<CartRepository>(CartRepositoryImpl());
  sl.registerSingleton<OrderRepository>(OrderRepositoryImpl());
  sl.registerSingleton<ReviewRepository>(ReviewRepositoryImpl());

//Usecases
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetAgesUseCase>(GetAgesUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SendPasswordResetEmailUseCase>(
      SendPasswordResetEmailUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<GetBannersUsecase>(GetBannersUsecase());
  sl.registerSingleton<GetCategoryUseCase>(GetCategoryUseCase());
  sl.registerSingleton<GetTopSellingUseCase>(GetTopSellingUseCase());
  sl.registerSingleton<GetNewInUseCase>(GetNewInUseCase());
  sl.registerSingleton<GetProductsByCategoryIdUseCase>(
      GetProductsByCategoryIdUseCase());
  sl.registerSingleton<GetProductsByTitleUseCase>(GetProductsByTitleUseCase());
  sl.registerSingleton<AddToCartUseCase>(AddToCartUseCase());
  sl.registerSingleton<GetCartProductsUseCase>(GetCartProductsUseCase());
  sl.registerSingleton<RemoveCartProductsUseCase>(RemoveCartProductsUseCase());
  sl.registerSingleton<OrderRegistrationUseCase>(OrderRegistrationUseCase());
  sl.registerSingleton<AddOrRemoveFavoriteProductUseCase>(
      AddOrRemoveFavoriteProductUseCase());
  sl.registerSingleton<IsFavoriteUseCase>(IsFavoriteUseCase());
  sl.registerSingleton<GetFavortiesProductsUseCase>(
      GetFavortiesProductsUseCase());
  sl.registerSingleton<GetOrdersUseCase>(GetOrdersUseCase());
  sl.registerSingleton<AddReviewUseCase>(AddReviewUseCase());
  sl.registerSingleton<GetReviewsUsecase>(GetReviewsUsecase());

  sl.registerFactory(
      () => ProductsDisplayCubit(useCase: sl<GetFavortiesProductsUseCase>()));
}
