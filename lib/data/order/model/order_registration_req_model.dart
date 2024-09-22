import 'package:e_commerce_application/data/order/model/order_status_model.dart';
import 'package:e_commerce_application/data/order/model/product_ordered_model.dart';
import 'package:e_commerce_application/domain/order/entity/order_status_entity.dart';
import 'package:e_commerce_application/domain/order/entity/product_ordered_entity.dart';

class OrderRegistrationReqModel {
  final String code;
  final List<ProductOrderedEntity> products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalPrice;
  final List<OrderStatusEntity> orderStatus;

  OrderRegistrationReqModel({
    required this.code,
    required this.products,
    required this.createdDate,
    required this.shippingAddress,
    required this.itemCount,
    required this.totalPrice,
    required this.orderStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'products': products.map((e) => e.fromEntity().toMap()).toList(),
      'createdDate': createdDate,
      'itemCount': itemCount,
      'totalPrice': totalPrice,
      'shippingAddress': shippingAddress,
      'orderStatus': orderStatus.map((e) => e.fromEntity().toMap()).toList(),
    };
  }
}
