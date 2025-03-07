import 'dart:convert';

class AddReviewReqModel {
  final String productId;
  final String review;
  final double rating;

  AddReviewReqModel({
    required this.productId,
    required this.review,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'review': review,
      'rating': rating,
    };
  }

  factory AddReviewReqModel.fromMap(Map<String, dynamic> map) {
    return AddReviewReqModel(
      productId: map['productId'] as String,
      review: map['review'] as String,
      rating: map['rating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddReviewReqModel.fromJson(String source) =>
      AddReviewReqModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
