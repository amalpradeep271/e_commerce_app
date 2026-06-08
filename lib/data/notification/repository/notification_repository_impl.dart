import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/notification/models/notification_model.dart';
import 'package:e_commerce_application/data/notification/source/notification_api_service.dart';
import 'package:e_commerce_application/domain/notification/entity/notification_entity.dart';
import 'package:e_commerce_application/domain/notification/repository/notification_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationApiService _notificationApiService = sl<NotificationApiService>();

  @override
  Future<Either<String, List<NotificationEntity>>> getNotifications() async {
    final response = await _notificationApiService.getNotifications();
    return response.fold(
      (error) => Left(error),
      (data) {
        try {
          final list = (data as List)
              .map((item) => NotificationModel.fromJson(item as Map<String, dynamic>))
              .toList();
          return Right(list);
        } catch (e) {
          return Left(e.toString());
        }
      },
    );
  }

  @override
  Future<Either<String, NotificationEntity>> markAsRead(String notificationId) async {
    final response = await _notificationApiService.markAsRead(notificationId);
    return response.fold(
      (error) => Left(error),
      (data) {
        try {
          final updated = NotificationModel.fromJson(data as Map<String, dynamic>);
          return Right(updated);
        } catch (e) {
          return Left(e.toString());
        }
      },
    );
  }
}
