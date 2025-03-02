import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class BannerFirebaseService {
  Future<Either> getBanners();
}

class BannerFirebaseServiceImpl extends BannerFirebaseService {
  @override
  Future<Either> getBanners() async {
    try {
      var banners =
          await FirebaseFirestore.instance.collection('Banners').get();
      return Right(banners.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again');
    }
  }
}
