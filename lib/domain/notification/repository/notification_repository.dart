import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/domain/notification/entity/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<String, List<NotificationEntity>>> getNotifications();
  Future<Either<String, NotificationEntity>> markAsRead(String notificationId);
}
