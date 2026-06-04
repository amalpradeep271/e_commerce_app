import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/address/repository/address_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class DeleteAddressUseCase extends UseCase<Either<String, String>, String> {
  @override
  Future<Either<String, String>> call({String? params}) async {
    return await sl<AddressRepository>().deleteAddress(params!);
  }
}
