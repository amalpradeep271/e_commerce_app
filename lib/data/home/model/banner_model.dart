// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_commerce_application/domain/home/entity/banner_entity.dart';

class BannerModel {
  final String bannerId;
  final String bannerImage;

  BannerModel({
    required this.bannerId,
    required this.bannerImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'BannerId': bannerId,
      'BannerImage': bannerImage,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      bannerId: map['BannerId'] as String,
      bannerImage: map['BannerImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension BannerModelX on BannerModel {
  BannerEntity toEntity() {
    return BannerEntity(
      bannerId: bannerId,
      bannerImage: bannerImage,
    );
  }
}
