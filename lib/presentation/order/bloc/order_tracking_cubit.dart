import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_application/domain/order/usecase/get_order_tracking_usecase.dart';
import 'package:e_commerce_application/presentation/order/bloc/order_tracking_state.dart';
import 'package:e_commerce_application/service_locator.dart';

class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  OrderTrackingCubit() : super(OrderTrackingInitial());

  Future<void> loadOrderTracking(String orderId) async {
    emit(OrderTrackingLoading());
    final result = await sl<GetOrderTrackingUseCase>().call(params: orderId);
    result.fold(
      (error) => emit(OrderTrackingFailure(errorMessage: error)),
      (steps) => emit(OrderTrackingLoaded(trackingSteps: steps)),
    );
  }
}
