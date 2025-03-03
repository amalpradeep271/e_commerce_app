import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/domain/product/entity/color_entity.dart';

class ProductEntity {
  final String categoryId;
  final List<ProductColorEntity> color;
  final Timestamp createdDate;
  final num discountPrice;
  final num gender;
  final List<String> images;
  final num price;
  final String productId;
  final List<String> sizes;
  final String title;
  final num salesNumber;
  final String description;
  final String dimensions;
  final String manufactureInformation;

  ProductEntity({
    required this.description,
    required this.dimensions,
    required this.manufactureInformation,
    required this.categoryId,
    required this.color,
    required this.createdDate,
    required this.discountPrice,
    required this.gender,
    required this.images,
    required this.price,
    required this.productId,
    required this.sizes,
    required this.title,
    required this.salesNumber,
  });
}
