import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';
import 'package:e_commerce_application/domain/order/entity/order_entity.dart';

import 'package:e_commerce_application/domain/order/entity/order_status_entity.dart';

abstract class OrderRepository {
  Future<Either<String, String>> orderRegistration(OrderRegistrationReqModel order);
  Future<Either<String, List<OrderEntity>>> getOrders();
  Future<Either<String, List<OrderStatusEntity>>> getOrderTracking(String orderId);
}
