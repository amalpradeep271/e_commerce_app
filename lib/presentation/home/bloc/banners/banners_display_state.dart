import 'package:e_commerce_application/domain/home/entity/banner_entity.dart';

abstract class BannersDisplayState {}

class BannersLoading extends BannersDisplayState {}

class BannersLoaded extends BannersDisplayState {
  final List<BannerEntity> banners;

  BannersLoaded({required this.banners});
}

class BannersLoadFailure extends BannersDisplayState {}
