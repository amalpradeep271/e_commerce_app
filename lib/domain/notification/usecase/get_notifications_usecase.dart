import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/notification/entity/notification_entity.dart';
import 'package:e_commerce_application/domain/notification/repository/notification_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetNotificationsUseCase extends UseCase<Either<String, List<NotificationEntity>>, dynamic> {
  @override
  Future<Either<String, List<NotificationEntity>>> call({params}) async {
    return await sl<NotificationRepository>().getNotifications();
  }
}
