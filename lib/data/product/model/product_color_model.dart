// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:e_commerce_application/domain/product/entity/color_entity.dart';

class ProductColorModel {
  final String title;
  final List<int> hexCode;

  ProductColorModel({
    required this.title,
    required this.hexCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'hexCode': hexCode,
    };
  }

  factory ProductColorModel.fromMap(Map<String, dynamic> map) {
    return ProductColorModel(
      title: map['title'] as String,
      hexCode: List<int>.from(
        map['hexCode'].map((e) => e),
      ),
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
