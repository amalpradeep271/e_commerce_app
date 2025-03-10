import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/domain/review/entity/review_entity.dart';

class ReviewModel {
  final String productId;
  final String review;
  final double rating;
  final String userName;
  final String userImage;
  final Timestamp createdDate;
  ReviewModel({
    required this.userName,
    required this.userImage,
    required this.productId,
    required this.review,
    required this.rating,
    required this.createdDate,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      productId: map['productId'] as String,
      review: map['review'] as String,
      rating: map['rating'] as double,
      userName: map['userName'] as String,
      userImage: map['userImage'] as String,
      createdDate: map['createdDate'] as Timestamp,
    );
  }

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension ReviewModelX on ReviewModel {
  ReviewEntity toEntity() {
    return ReviewEntity(
      userImage: userImage,
      userName: userName,
      createdDate: createdDate,
      productId: productId,
      rating: rating,
      review: review,
    );
  }
}
