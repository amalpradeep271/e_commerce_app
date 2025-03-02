import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/home/model/banner_model.dart';
import 'package:e_commerce_application/data/home/source/banner_firebase_service.dart';
import 'package:e_commerce_application/domain/home/repository/banner_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class BannerRepositoryImpl extends BannerRepository {
  @override
  Future<Either> getBanners() async{
  var banners = await sl<BannerFirebaseService>().getBanners();
    return banners.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(data).map(
            (e) => BannerModel.fromMap(e).toEntity(),
          ).toList(),
        );
      },
    );
  }
  
}