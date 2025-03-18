// // Product State
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_application/data/product/model/product_model.dart';
// import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class ProductState {}

// class ProductInitial extends ProductState {}

// class ProductLoading extends ProductState {}

// class ProductLoaded extends ProductState {
//   final List<ProductEntity> products;
//   ProductLoaded(this.products);
// }

// class ProductError extends ProductState {
//   final String message;
//   ProductError(this.message);
// }

// // Product Cubit
// class ProductCubit extends Cubit<ProductState> {
//   ProductCubit() : super(ProductInitial());

//   void fetchProducts() async {
//     emit(ProductLoading());
//     try {
//       FirebaseFirestore.instance
//           .collection('Products')
//           .snapshots()
//           .listen((snapshot) {
//         final products = snapshot.docs
//             .map((doc) => ProductModel.fromMap(doc.data()).toEntity())
//             .toList();
//         emit(ProductLoaded(products));
//       });
//     } catch (e) {
//       emit(ProductError("Failed to load products"));
//     }
//   }
// }

// // Wishlist State


// // Wishlist Cubit

