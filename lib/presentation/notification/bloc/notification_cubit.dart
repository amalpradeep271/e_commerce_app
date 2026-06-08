import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_application/domain/notification/usecase/get_notifications_usecase.dart';
import 'package:e_commerce_application/domain/notification/usecase/mark_as_read_usecase.dart';
import 'package:e_commerce_application/presentation/notification/bloc/notification_state.dart';
import 'package:e_commerce_application/service_locator.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> loadNotifications() async {
    emit(NotificationLoading());
    final result = await sl<GetNotificationsUseCase>().call();
    result.fold(
      (error) => emit(NotificationFailure(errorMessage: error)),
      (notifications) => emit(NotificationLoaded(notifications: notifications)),
    );
  }

  Future<void> markNotificationAsRead(String id) async {
    final result = await sl<MarkAsReadUseCase>().call(params: id);
    result.fold(
      (error) => null, // Fail silently or log error
      (updatedNotification) {
        // Reload list to update UI state
        loadNotifications();
      },
    );
  }
}
