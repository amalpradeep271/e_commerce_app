import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/domain/review/entity/review_entity.dart';

Timestamp _parseTimestamp(dynamic value) {
  if (value is Timestamp) {
    return value;
  }
  if (value is String) {
    return Timestamp.fromDate(DateTime.parse(value));
  }
  if (value is Map) {
    final seconds = value['_seconds'] ?? 0;
    final nanoseconds = value['_nanoseconds'] ?? 0;
    return Timestamp(seconds, nanoseconds);
  }
  return Timestamp.now();
}

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
      productId: (map['productId'] ?? '') as String,
      review: (map['review'] ?? map['reviewContent'] ?? '') as String,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      userName: (map['userName'] ?? map['creatorName'] ?? '') as String,
      userImage: (map['userImage'] ?? map['creatorImage'] ?? '') as String,
      createdDate: _parseTimestamp(map['createdDate']),
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
