import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/address/entity/address_entity.dart';
import 'package:e_commerce_application/domain/address/repository/address_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetAddressesUseCase extends UseCase<Either<String, List<AddressEntity>>, dynamic> {
  @override
  Future<Either<String, List<AddressEntity>>> call({params}) async {
    return await sl<AddressRepository>().getAddresses();
  }
}
