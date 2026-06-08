import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewEntity {
  final String productId;
  final String review;
  final double rating;
  final String userName;
  final String userImage;
  final Timestamp createdDate;
  ReviewEntity({
    required this.userName,
    required this.userImage,
    required this.productId,
    required this.review,
    required this.rating,
    required this.createdDate,
  });
}
