import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/order/entity/order_status_entity.dart';
import 'package:e_commerce_application/domain/order/repository/order_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetOrderTrackingUseCase extends UseCase<Either<String, List<OrderStatusEntity>>, String> {
  @override
  Future<Either<String, List<OrderStatusEntity>>> call({String? params}) async {
    return await sl<OrderRepository>().getOrderTracking(params!);
  }
}
