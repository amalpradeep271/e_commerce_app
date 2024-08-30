import 'package:dartz/dartz.dart';

abstract class ProductFirebaseService {
    Future<Either> getTopSelling();

}


class ProductFirebaseServiceImpl extends ProductFirebaseService {
  @override
  Future<Either> getTopSelling() {
    // TODO: implement getTopSelling
    throw UnimplementedError();
  }
  
}