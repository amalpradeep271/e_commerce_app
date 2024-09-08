// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:e_commerce_application/domain/product/entity/color_entity.dart';

class ProductColorModel {
  final String title;
  final String hexCode;

  ProductColorModel({
    required this.title,
    required this.hexCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hexCode': hexCode,
      'title': title,
    };
  }

  factory ProductColorModel.fromMap(Map<String, dynamic> map) {
    return ProductColorModel(
      title: map['title'] as String,
      hexCode: map['hexCode'] as String,
    );
  }
}

extension ProductColorModelX on ProductColorModel {
  ProductColorEntity toEntity() {
    return ProductColorEntity(
      title: title,
      hexCode: hexCode,
    );
  }
}

extension ProductColorXEntity on ProductColorEntity {
  ProductColorModel fromEntity() {
    return ProductColorModel(
      title: title,
      hexCode: hexCode,
    );
  }
}
