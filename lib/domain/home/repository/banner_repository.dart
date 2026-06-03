import 'package:dartz/dartz.dart';

import 'package:e_commerce_application/domain/home/entity/banner_entity.dart';

abstract class BannerRepository {
  Future<Either<String, List<BannerEntity>>> getBanners();
  void clearCache();
}
