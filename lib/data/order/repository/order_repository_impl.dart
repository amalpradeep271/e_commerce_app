import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/mapping_helper.dart';
import 'package:e_commerce_application/data/order/model/order_model.dart';
import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';
import 'package:e_commerce_application/data/order/source/order_api_service.dart';
import 'package:e_commerce_application/domain/order/entity/order_entity.dart';
import 'package:e_commerce_application/domain/order/repository/order_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<Either<String, String>> orderRegistration(OrderRegistrationReqModel order) async {
    final returnedData = await sl<OrderApiService>().orderRegistration(order);
    return returnedData.fold(
      (error) => Left(error),
      (message) => Right(message as String),
    );
  }

  @override
  Future<Either<String, List<OrderEntity>>> getOrders() async {
    final returnedData = await sl<OrderApiService>().getOrders();
    return mapListResponse<OrderEntity>(
      returnedData,
      (e) => OrderModel.fromMap(e).toEntity(),
    );
  }
}
