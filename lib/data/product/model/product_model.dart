import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/product/model/product_color_model.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

class ProductModel {
  final String categoryId;
  final List<ProductColorModel> color;
  final Timestamp createdDate;
  final num discountPrice;
  final num gender;
  final List<String> images;
  final num price;
  final String productId;
  final List<String> sizes;
  final num salesNumber;
  final String title;
  final String description;
  final String dimensions;
  final String manufactureInformation;

  ProductModel({
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
    required this.salesNumber,
    required this.title,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      categoryId: map['categoryId'] as String,
      color: List<ProductColorModel>.from(
        map['colors'].map(
          (e) => ProductColorModel.fromMap(e),
        ),
      ),
      createdDate: map['createdDate'] as Timestamp,
      discountPrice: map['discountPrice'] as num,
      gender: map['gender'] as num,
      images: List<String>.from(map['images'].map((e) => e.toString())),
      price: map['price'] as num,
      productId: map['productId'] as String,
      sizes: List<String>.from(map['sizes'].map((e) => e.toString())),
      salesNumber: map['salesNumber'] as num,
      title: map['title'] as String,
      description: map['description'] as String,
      dimensions: map['dimensions'] as String,
      manufactureInformation: map['manufacture information'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'colors': color.map((e) => e.toMap()).toList(),
      'createdDate': createdDate,
      'discountPrice': discountPrice,
      'gender': gender,
      'images': images.map((e) => e.toString()).toList(),
      'price': price,
      'sizes': sizes.map((e) => e.toString()).toList(),
      'productId': productId,
      'salesNumber': salesNumber,
      'title': title,
      'description': description,
      'dimensions': dimensions,
      'manufacture information': manufactureInformation,
    };
  }
}

extension ProductModelX on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      description: description,
      dimensions: dimensions,
      manufactureInformation: manufactureInformation,
      categoryId: categoryId,
      color: color.map((e) => e.toEntity()).toList(),
      createdDate: createdDate,
      discountPrice: discountPrice,
      gender: gender,
      images: images,
      price: price,
      productId: productId,
      sizes: sizes,
      title: title,
      salesNumber: salesNumber,
    );
  }
}

extension ProductXEntity on ProductEntity {
  ProductModel fromEntity() {
    return ProductModel(
      description: description,
      dimensions: dimensions,
      manufactureInformation: manufactureInformation,
      categoryId: categoryId,
      color: color.map((e) => e.fromEntity()).toList(),
      createdDate: createdDate,
      discountPrice: discountPrice,
      gender: gender,
      images: images,
      price: price,
      sizes: sizes,
      productId: productId,
      salesNumber: salesNumber,
      title: title,
    );
  }
}
