// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddToCartReq {
  final String productId;
  final String productTitle;
  final int productQuantity;
  final String productColor;
  final String productSize;
  final double productPrice;
  final double discountPrice;
  final double totalPrice;
  final String productImage;
  final String createdDate;

  AddToCartReq({
    required this.productId,
    required this.productTitle,
    required this.productQuantity,
    required this.productColor,
    required this.productSize,
    required this.productPrice,
    required this.discountPrice,
    required this.totalPrice,
    required this.productImage,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productTitle': productTitle,
      'prodctQuantity': productQuantity,
      'productColor': productColor,
      'productSize': productSize,
      'productPrice': productPrice,
      'discountPrice':discountPrice,
      'totalPrice': totalPrice,
      'productImage': productImage,
      'createdDate': createdDate,
    };
  }

  factory AddToCartReq.fromMap(Map<String, dynamic> map) {
    return AddToCartReq(
      productId: map['productId'] as String,
      productTitle: map['productTitle'] as String,
      productQuantity: map['prodctQuantity'] as int,
      productColor: map['productColor'] as String,
      productSize: map['productSize'] as String,
      discountPrice: map['discountPrice'] as double,
      productPrice: map['productPrice'] as double,
      totalPrice: map['totalPrice'] as double,
      productImage: map['productImage'] as String,
      createdDate: map['createdDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartReq.fromJson(String source) =>
      AddToCartReq.fromMap(json.decode(source) as Map<String, dynamic>);
}
