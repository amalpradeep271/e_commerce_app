import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/cart/model/add_to_cart_req_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CartFirebaseServices {
  Future<Either> addToCart(AddToCartReq addToCartReq);
  Future<Either> getCartProducts();
  Future<Either> removeCartProduct(String id);
  Future<Either> isProductInCart(String productId);
}

class CartFirebaseServicesImpl extends CartFirebaseServices {
  @override
  Future<Either> addToCart(AddToCartReq addToCartReq) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.uid)
          .collection('Cart')
          .add(
            addToCartReq.toMap(),
          );
      return const Right('Added to cart successfully');
    } catch (e) {
      return const Left('Please try again.');
    }
  }

  @override
  Future<Either> getCartProducts() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .get();

      List<Map> products = [];
      for (var item in returnedData.docs) {
        var data = item.data();
        data.addAll({'id': item.id});
        products.add(data);
      }
      return Right(products);
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> removeCartProduct(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .doc(id)
          .delete();
      return const Right('Product removed successfully');
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> isProductInCart(String productId) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var cartQuery = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .where('productId', isEqualTo: productId)
          .get();

      return Right(cartQuery.docs.isNotEmpty);
    } catch (e) {
      return const Left('Failed to check cart status');
    }
  }
}
