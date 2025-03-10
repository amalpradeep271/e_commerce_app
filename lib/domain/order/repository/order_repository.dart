import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';

abstract class OrderRepository {

  Future<Either> orderRegistration(OrderRegistrationReqModel order);
  Future<Either> getOrders();
}
