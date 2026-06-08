import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class AddressApiService {
  Future<Either<String, dynamic>> getAddresses();
  Future<Either<String, dynamic>> addAddress(Map<String, dynamic> data);
  Future<Either<String, dynamic>> updateAddress(String id, Map<String, dynamic> data);
  Future<Either<String, dynamic>> deleteAddress(String id);
}

class AddressApiServiceImpl extends AddressApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> getAddresses() async {
    return _apiClient.getRequest('/addresses');
  }

  @override
  Future<Either<String, dynamic>> addAddress(Map<String, dynamic> data) async {
    return _apiClient.postRequest('/addresses', data);
  }

  @override
  Future<Either<String, dynamic>> updateAddress(String id, Map<String, dynamic> data) async {
    return _apiClient.putRequest('/addresses/$id', data);
  }

  @override
  Future<Either<String, dynamic>> deleteAddress(String id) async {
    return _apiClient.deleteRequest('/addresses/$id');
  }
}
