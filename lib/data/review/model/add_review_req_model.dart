import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddReviewReqModel {
  final String productId;
  final String review;
  final double rating;
  final String userName;
  final String userImage;
  final Timestamp createdDate;

  AddReviewReqModel({
    required this.userName,
    required this.userImage,
    required this.productId,
    required this.review,
    required this.rating,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'review': review,
      'rating': rating,
      'createdDate': createdDate,
      'userName': userName,
      'userImage': userImage,
    };
  }

  factory AddReviewReqModel.fromMap(Map<String, dynamic> map) {
    return AddReviewReqModel(
      productId: map['productId'] as String,
      review: map['review'] as String,
      rating: map['rating'] as double,
      userName: map['userName'] as String,
      userImage: map['userImage'] as String,
      createdDate: map['createdDate'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddReviewReqModel.fromJson(String source) =>
      AddReviewReqModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
