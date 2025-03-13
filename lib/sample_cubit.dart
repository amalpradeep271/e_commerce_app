// Product State
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/product/model/product_model.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

// Product Cubit
class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void fetchProducts() async {
    emit(ProductLoading());
    try {
      FirebaseFirestore.instance
          .collection('Products')
          .snapshots()
          .listen((snapshot) {
        final products = snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()).toEntity())
            .toList();
        emit(ProductLoaded(products));
      });
    } catch (e) {
      emit(ProductError("Failed to load products"));
    }
  }
}

// Wishlist State
abstract class WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductEntity> wishlistedItems;
  WishlistLoaded(this.wishlistedItems);
}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}

// Wishlist Cubit
class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistLoading());

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  void toggleWishlist(ProductEntity product) async {
    try {
      final collection = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Wishlist');
      final docRef = collection.doc(product.productId);
      final snapshot = await docRef.get();

      if (state is WishlistLoaded) {
        final currentWishlist =
            List<ProductEntity>.from((state as WishlistLoaded).wishlistedItems);
        if (snapshot.exists) {
          await docRef.delete();
          currentWishlist.removeWhere((p) => p.productId == product.productId);
        } else {
          await docRef.set({'productId': product.productId});
          currentWishlist.add(product);
        }
        emit(WishlistLoaded(currentWishlist));
      }
    } catch (e) {
      emit(WishlistError('Failed to update wishlist'));
    }
  }

  void loadWishlist() async {
    try {
      emit(WishlistLoading());
      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Wishlist')
          .get();
      List<String> wishlistedIds = snapshot.docs.map((doc) => doc.id).toList();
      if (wishlistedIds.isNotEmpty) {
        final productsSnapshot = await FirebaseFirestore.instance
            .collection('Products')
            .where('productId', whereIn: wishlistedIds)
            .get();
        final wishlistedProducts = productsSnapshot.docs
            .map(
              (doc) => ProductModel.fromMap(doc.data()).toEntity(),
            )
            .toList();
        emit(WishlistLoaded(wishlistedProducts));
      } else {
        emit(WishlistLoaded([]));
      }
    } catch (e) {
      emit(WishlistError('Failed to load wishlist'));
    }
  }
}
