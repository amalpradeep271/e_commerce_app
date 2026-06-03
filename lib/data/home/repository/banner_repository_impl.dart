import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/mapping_helper.dart';
import 'package:e_commerce_application/data/home/model/banner_model.dart';
import 'package:e_commerce_application/data/home/source/banner_api_service.dart';
import 'package:e_commerce_application/domain/home/entity/banner_entity.dart';
import 'package:e_commerce_application/domain/home/repository/banner_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class BannerRepositoryImpl extends BannerRepository {
  List<BannerEntity>? _cachedBanners;

  @override
  void clearCache() {
    _cachedBanners = null;
  }

  @override
  Future<Either<String, List<BannerEntity>>> getBanners() async {
    if (_cachedBanners != null) {
      return Right(_cachedBanners!);
    }
    var banners = await sl<BannerApiService>().getBanners();
    var result = mapListResponse<BannerEntity>(
      banners,
      (e) => BannerModel.fromMap(e).toEntity(),
    );
    result.fold(
      (error) => null,
      (data) => _cachedBanners = data,
    );
    return result;
  }
}