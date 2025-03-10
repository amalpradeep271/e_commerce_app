// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';

class ProductOrderedModel {
  final String productId;
  final String productTitle;
  final num productQuantity;
  final String productColor;
  final String productSize;
  final num productPrice;
  final num discountPrice;
  final num totalPrice;
  final String productImage;
  final String createdDate;
  final String id;

  ProductOrderedModel({
    required this.productId,
    required this.productTitle,
    required this.productQuantity,
    required this.productColor,
    required this.productSize,
    required this.productPrice,
    required this.discountPrice,
    required this.totalPrice,
    required this.productImage,
    required this.createdDate,
    required this.id,
  });

  factory ProductOrderedModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderedModel(
      productId: map['productId'] as String,
      productTitle: map['productTitle'] as String,
      productQuantity: map['prodctQuantity'] as num,
      productColor: map['productColor'] as String,
      productSize: map['productSize'] as String,
      productPrice: map['productPrice'] as num,
      discountPrice: map['discountPrice'] as num,
      totalPrice: map['totalPrice'] as num,
      productImage: map['productImage'] as String,
      createdDate: map['createdDate'] as String,
      id: map['id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productTitle': productTitle,
      'prodctQuantity': productQuantity,
      'productColor': productColor,
      'productSize': productSize,
      'productPrice': productPrice,
      'discountPrice': discountPrice,
      'totalPrice': totalPrice,
      'productImage': productImage,
      'createdDate': createdDate,
      'id': id,
    };
  }
}

extension ProductOrderedXModel on ProductOrderedModel {
  ProductOrderedEntity toEntity() {
    return ProductOrderedEntity(
      productId: productId,
      productTitle: productTitle,
      productQuantity: productQuantity,
      productColor: productColor,
      productSize: productSize,
      productPrice: productPrice,
      discountPrice: discountPrice,
      totalPrice: totalPrice,
      productImage: productImage,
      createdDate: createdDate,
      id: id,
    );
  }
}

extension ProductOrderedXEntity on ProductOrderedEntity {
  ProductOrderedModel fromEntity() {
    return ProductOrderedModel(
      productId: productId,
      productTitle: productTitle,
      productQuantity: productQuantity,
      productColor: productColor,
      productSize: productSize,
      productPrice: productPrice,
      discountPrice: discountPrice,
      totalPrice: totalPrice,
      productImage: productImage,
      createdDate: createdDate,
      id: id,
    );
  }
}
