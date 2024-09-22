import 'package:e_commerce_application/data/order/model/product_ordered_model.dart';
import 'package:e_commerce_application/domain/order/entity/product_ordered_entity.dart';

class OrderRegistrationReqModel {
  final String code;
  final List<ProductOrderedEntity> products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalPrice;

  OrderRegistrationReqModel({
    required this.code,
    required this.products,
    required this.createdDate,
    required this.shippingAddress,
    required this.itemCount,
    required this.totalPrice,
  });


    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code':code,
      'products': products.map((e) => e.fromEntity().toMap()).toList(),
      'createdDate': createdDate,
      'itemCount': itemCount,
      'totalPrice': totalPrice,
      'shippingAddress' : shippingAddress
    };
  }
}
