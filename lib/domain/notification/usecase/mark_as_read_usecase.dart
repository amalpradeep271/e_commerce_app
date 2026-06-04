import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/notification/entity/notification_entity.dart';
import 'package:e_commerce_application/domain/notification/repository/notification_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class MarkAsReadUseCase extends UseCase<Either<String, NotificationEntity>, String> {
  @override
  Future<Either<String, NotificationEntity>> call({String? params}) async {
    return await sl<NotificationRepository>().markAsRead(params!);
  }
}
