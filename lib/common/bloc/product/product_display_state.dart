import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

abstract class ProductsDisplayState {}

class ProductsInitialState extends ProductsDisplayState {}

class ProductsLoading extends ProductsDisplayState {}

class ProductsLoaded extends ProductsDisplayState {
  final List<ProductEntity> products;
  ProductsLoaded({required this.products});
}

class LoadProductsFailure extends ProductsDisplayState {}
