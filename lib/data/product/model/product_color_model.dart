// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:e_commerce_application/domain/product/entity/color_entity.dart';

class ProductColorModel {
  final String title;
  final List<num> rgb;

  ProductColorModel({
    required this.title,
    required this.rgb,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rgb': rgb,
      'title': title,
    };
  }

  factory ProductColorModel.fromMap(Map<String, dynamic> map) {
    return ProductColorModel(
      title: map['title'] as String,
      rgb: List<num>.from(
        map['rgb'].map((e) => e),
      ),
    );
  }
}

extension ProductColorModelX on ProductColorModel {
  ProductColorEntity toEntity() {
    return ProductColorEntity(
      title: title,
      rgb: rgb,
    );
  }
}

extension ProductColorXEntity on ProductColorEntity {
  ProductColorModel fromEntity() {
    return ProductColorModel(
      title: title,
      rgb: rgb,
    );
  }
}
