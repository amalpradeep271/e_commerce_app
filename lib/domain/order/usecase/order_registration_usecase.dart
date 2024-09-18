import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';
import 'package:e_commerce_application/domain/order/repository/order_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class OrderRegistrationUseCase
    implements UseCase<Either, OrderRegistrationReqModel> {
  @override
  Future<Either> call({OrderRegistrationReqModel? params}) async {
    return sl<OrderRepository>().orderRegistration(params!);
  }
}
