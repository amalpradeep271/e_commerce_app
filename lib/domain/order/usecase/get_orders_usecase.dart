import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/order/entity/order_entity.dart';
import 'package:e_commerce_application/domain/order/repository/order_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetOrdersUseCase implements UseCase<Either<String, List<OrderEntity>>, dynamic> {
  @override
  Future<Either<String, List<OrderEntity>>> call({dynamic params}) async {
    return sl<OrderRepository>().getOrders();
  }
}
