import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/data/auth/repository/auth_repository_impl.dart';
import 'package:e_commerce_application/data/auth/source/auth_api_service.dart';
import 'package:e_commerce_application/data/cart/repository/cart_repository_impl.dart';
import 'package:e_commerce_application/data/cart/source/cart_api_services.dart';
import 'package:e_commerce_application/data/category/repository/category_repository_impl.dart';
import 'package:e_commerce_application/data/category/source/category_api_service.dart';
import 'package:e_commerce_application/data/home/repository/banner_repository_impl.dart';
import 'package:e_commerce_application/data/home/source/banner_api_service.dart';
import 'package:e_commerce_application/data/order/repository/order_repository_impl.dart';
import 'package:e_commerce_application/data/order/source/order_api_service.dart';
import 'package:e_commerce_application/data/product/repository/product_repository_impl.dart';
import 'package:e_commerce_application/data/product/source/product_api_service.dart';
import 'package:e_commerce_application/data/review/repository/review_repository_impl.dart';
import 'package:e_commerce_application/data/review/source/review_api_services.dart';
import 'package:e_commerce_application/data/user/repository/user_repository_impl.dart';
import 'package:e_commerce_application/data/user/source/user_api_services.dart';
import 'package:e_commerce_application/data/wishlist/repository/wishlist_repository_impl.dart';
import 'package:e_commerce_application/data/wishlist/source/wishlist_api_service.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/domain/auth/usecase/get_ages_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/get_user_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/is_logged_in_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/send_password_reset_email_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/signin_usecase.dart';
import 'package:e_commerce_application/domain/auth/usecase/signup_usecase.dart';
import 'package:e_commerce_application/domain/cart/repository/cart_repository.dart';
import 'package:e_commerce_application/domain/cart/usecase/is_product_in_cart_usecase.dart';
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
import 'package:e_commerce_application/domain/user/repository/user_repository.dart';
import 'package:e_commerce_application/domain/user/usecase/upload_user_image_usecase.dart';
import 'package:e_commerce_application/domain/wishlist/repository/wishlist_repository.dart';
import 'package:e_commerce_application/domain/wishlist/usecase/get_wishlist_usecase.dart';
import 'package:e_commerce_application/domain/wishlist/usecase/toggle_wishlist_usecase.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:get_it/get_it.dart';

// New Address imports
import 'package:e_commerce_application/data/address/source/address_api_service.dart';
import 'package:e_commerce_application/domain/address/repository/address_repository.dart';
import 'package:e_commerce_application/data/address/repository/address_repository_impl.dart';
import 'package:e_commerce_application/domain/address/usecase/get_addresses_usecase.dart';
import 'package:e_commerce_application/domain/address/usecase/add_address_usecase.dart';
import 'package:e_commerce_application/domain/address/usecase/update_address_usecase.dart';
import 'package:e_commerce_application/domain/address/usecase/delete_address_usecase.dart';
import 'package:e_commerce_application/presentation/address/bloc/address_cubit.dart';

// New Coupon imports
import 'package:e_commerce_application/data/coupon/source/coupon_api_service.dart';
import 'package:e_commerce_application/domain/coupon/repository/coupon_repository.dart';
import 'package:e_commerce_application/data/coupon/repository/coupon_repository_impl.dart';
import 'package:e_commerce_application/domain/coupon/usecase/validate_coupon_usecase.dart';
import 'package:e_commerce_application/presentation/cart/bloc/coupon_cubit.dart';

// New Notification imports
import 'package:e_commerce_application/data/notification/source/notification_api_service.dart';
import 'package:e_commerce_application/domain/notification/repository/notification_repository.dart';
import 'package:e_commerce_application/data/notification/repository/notification_repository_impl.dart';
import 'package:e_commerce_application/domain/notification/usecase/get_notifications_usecase.dart';
import 'package:e_commerce_application/domain/notification/usecase/mark_as_read_usecase.dart';
import 'package:e_commerce_application/presentation/notification/bloc/notification_cubit.dart';

// New Order Tracking imports
import 'package:e_commerce_application/domain/order/usecase/get_order_tracking_usecase.dart';
import 'package:e_commerce_application/presentation/order/bloc/order_tracking_cubit.dart';

// New Profile imports
import 'package:e_commerce_application/domain/user/usecase/get_user_usecase.dart';
import 'package:e_commerce_application/presentation/settings/bloc/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Api Client
  sl.registerSingleton<ApiClient>(ApiClient());

//Services

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<BannerApiService>(BannerApiServiceImpl());
  sl.registerSingleton<UserApiService>(UserApiServiceImpl());
  sl.registerSingleton<CategoryApiService>(CategoryApiServiceImpl());
  sl.registerSingleton<ProductApiService>(ProductApiServiceImpl());
  sl.registerSingleton<CartApiService>(CartApiServiceImpl());
  sl.registerSingleton<OrderApiService>(OrderApiServiceImpl());
  sl.registerSingleton<ReviewApiService>(ReviewApiServiceImpl());
  sl.registerSingleton<WishlistApiService>(WishlistApiServiceImpl());

  // Register new services
  sl.registerSingleton<AddressApiService>(AddressApiServiceImpl());
  sl.registerSingleton<CouponApiService>(CouponApiServiceImpl());
  sl.registerSingleton<NotificationApiService>(NotificationApiServiceImpl());

//Repositories

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<BannerRepository>(BannerRepositoryImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());
  sl.registerSingleton<CartRepository>(CartRepositoryImpl());
  sl.registerSingleton<OrderRepository>(OrderRepositoryImpl());
  sl.registerSingleton<ReviewRepository>(ReviewRepositoryImpl());
  sl.registerSingleton<WishlistRepository>(WishlistRepositoryImpl());

  // Register new repositories
  sl.registerSingleton<AddressRepository>(AddressRepositoryImpl());
  sl.registerSingleton<CouponRepository>(CouponRepositoryImpl());
  sl.registerSingleton<NotificationRepository>(NotificationRepositoryImpl());

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
  sl.registerSingleton<UploadUserImageUsecase>(UploadUserImageUsecase());

  sl.registerSingleton<AddReviewUseCase>(AddReviewUseCase());
  sl.registerSingleton<GetReviewsUsecase>(GetReviewsUsecase());
  sl.registerSingleton<ToggleWishlistUseCase>(ToggleWishlistUseCase());
  sl.registerSingleton<GetWishlistUseCase>(GetWishlistUseCase());
  sl.registerSingleton<IsProductInCartUsecase>(IsProductInCartUsecase());

  // Register new usecases
  sl.registerSingleton<GetAddressesUseCase>(GetAddressesUseCase());
  sl.registerSingleton<AddAddressUseCase>(AddAddressUseCase());
  sl.registerSingleton<UpdateAddressUseCase>(UpdateAddressUseCase());
  sl.registerSingleton<DeleteAddressUseCase>(DeleteAddressUseCase());
  sl.registerSingleton<ValidateCouponUseCase>(ValidateCouponUseCase());
  sl.registerSingleton<GetNotificationsUseCase>(GetNotificationsUseCase());
  sl.registerSingleton<MarkAsReadUseCase>(MarkAsReadUseCase());
  sl.registerSingleton<GetOrderTrackingUseCase>(GetOrderTrackingUseCase());
  sl.registerSingleton<GetUserProfileUseCase>(GetUserProfileUseCase());

  // Register cubits as factories
  sl.registerFactory(() => AddressCubit());
  sl.registerFactory(() => CouponCubit());
  sl.registerFactory(() => NotificationCubit());
  sl.registerFactory(() => OrderTrackingCubit());
  sl.registerFactory(() => ProfileCubit());

  sl.registerFactory(
      () => ProductsDisplayCubit(useCase: sl<GetFavortiesProductsUseCase>()));
}
