import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class NotificationApiService {
  Future<Either<String, dynamic>> getNotifications();
  Future<Either<String, dynamic>> markAsRead(String notificationId);
}

class NotificationApiServiceImpl extends NotificationApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> getNotifications() async {
    return _apiClient.getRequest('/notifications');
  }

  @override
  Future<Either<String, dynamic>> markAsRead(String notificationId) async {
    return _apiClient.patchRequest('/notifications/$notificationId/read', {});
  }
}
