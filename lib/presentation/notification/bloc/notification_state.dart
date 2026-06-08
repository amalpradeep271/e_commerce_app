import 'package:e_commerce_application/domain/notification/entity/notification_entity.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  NotificationLoaded({required this.notifications});
}

class NotificationFailure extends NotificationState {
  final String errorMessage;
  NotificationFailure({required this.errorMessage});
}
