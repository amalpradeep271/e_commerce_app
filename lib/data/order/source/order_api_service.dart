import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class OrderApiService {
  Future<Either<String, dynamic>> orderRegistration(OrderRegistrationReqModel order);
  Future<Either<String, dynamic>> getOrders();
}

class OrderApiServiceImpl extends OrderApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> orderRegistration(OrderRegistrationReqModel order) async {
    return _apiClient.postRequest('/orders', order.toMap());
  }

  @override
  Future<Either<String, dynamic>> getOrders() async {
    return _apiClient.getRequest('/orders');
  }
}
