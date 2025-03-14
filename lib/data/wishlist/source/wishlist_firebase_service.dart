import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class WishlistFireBaseService {
  Future<Either<String, List<Map<String, dynamic>>>> getWishlist();
  Future<Either<String, void>> toggleWishlist(String productId);
}

class WishlistFirebaseServiceImpl extends WishlistFireBaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String get userId => auth.currentUser?.uid ?? '';

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getWishlist() async {
    try {
      var wishlists = await firestore
          .collection('Users')
          .doc(userId)
          .collection('Wishlist')
          .get();
      List<String> wishlistedIds = wishlists.docs.map((doc) => doc.id).toList();
      if (wishlistedIds.isEmpty) {
        return const Right([]);
      }
      var productsSnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('productId', whereIn: wishlistedIds)
          .get();
      return Right(productsSnapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      return const Left('Failed to load wishlist');
    }
  }

  @override
  Future<Either<String, void>> toggleWishlist(String productId) async {
    try {
      final docRef = firestore
          .collection('Users')
          .doc(userId)
          .collection('Wishlist')
          .doc(productId);
      final snapshot = await docRef.get();

      if (snapshot.exists) {
        await docRef.delete();
      } else {
        await docRef.set({'productId': productId});
      }
      return const Right(null);
    } catch (e) {
      return const Left('Failed to update wishlist');
    }
  }
}
