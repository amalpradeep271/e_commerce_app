import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/domain/address/entity/address_entity.dart';

abstract class AddressRepository {
  Future<Either<String, List<AddressEntity>>> getAddresses();
  Future<Either<String, AddressEntity>> addAddress(AddressEntity address);
  Future<Either<String, AddressEntity>> updateAddress(AddressEntity address);
  Future<Either<String, String>> deleteAddress(String id);
}
