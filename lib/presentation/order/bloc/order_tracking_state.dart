import 'package:e_commerce_application/domain/order/entity/order_status_entity.dart';

abstract class OrderTrackingState {}

class OrderTrackingInitial extends OrderTrackingState {}

class OrderTrackingLoading extends OrderTrackingState {}

class OrderTrackingLoaded extends OrderTrackingState {
  final List<OrderStatusEntity> trackingSteps;
  OrderTrackingLoaded({required this.trackingSteps});
}

class OrderTrackingFailure extends OrderTrackingState {
  final String errorMessage;
  OrderTrackingFailure({required this.errorMessage});
}
