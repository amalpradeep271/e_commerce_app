import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class CategoryApiService {
  Future<Either<String, dynamic>> getCategories();
}

class CategoryApiServiceImpl extends CategoryApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> getCategories() async {
    return _apiClient.getRequest('/categories');
  }
}
