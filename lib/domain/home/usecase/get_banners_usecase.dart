import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/home/repository/banner_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetBannersUsecase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<BannerRepository>().getBanners();
  }
}
