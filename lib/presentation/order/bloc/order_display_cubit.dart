import 'package:e_commerce_application/domain/order/usecase/get_orders_usecase.dart';
import 'package:e_commerce_application/presentation/order/bloc/order_display_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersDisplayCubit extends Cubit<OrdersDisplayState> {
  OrdersDisplayCubit() : super(OrdersLoading());

  void displayOrders() async {
    if (isClosed) return;
    var returnedData = await sl<GetOrdersUseCase>().call();
    if (isClosed) return;
    returnedData.fold(
      (error){
        if (!isClosed) emit(LoadOrdersFailure(errorMessage: error));
      }, 
      (orders) {
        if (!isClosed) emit(OrdersLoaded(orders: orders));
      }
    );
  }
}