import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/address/entity/address_entity.dart';
import 'package:e_commerce_application/domain/address/repository/address_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class UpdateAddressUseCase extends UseCase<Either<String, AddressEntity>, AddressEntity> {
  @override
  Future<Either<String, AddressEntity>> call({AddressEntity? params}) async {
    return await sl<AddressRepository>().updateAddress(params!);
  }
}
