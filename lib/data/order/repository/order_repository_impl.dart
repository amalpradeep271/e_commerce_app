import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/order/model/order_model.dart';
import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';
import 'package:e_commerce_application/data/order/source/order_firebase_service.dart';
import 'package:e_commerce_application/domain/order/repository/order_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<Either> orderRegistration(OrderRegistrationReqModel order) async {
    var returnedData =
        await sl<OrderFirebaseService>().orderRegistration(order);
    return returnedData.fold((error) {
      return Left(error);
    }, (message) {
      return Right(message);
    });
  }

  @override
  Future<Either> getOrders() async {
    var returnedData = await sl<OrderFirebaseService>().getOrders();
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => OrderModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
