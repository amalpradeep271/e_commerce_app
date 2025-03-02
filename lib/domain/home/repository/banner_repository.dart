import 'package:dartz/dartz.dart';

abstract class BannerRepository {
  Future<Either> getBanners();
}
