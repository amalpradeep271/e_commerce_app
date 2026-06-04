import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_application/domain/coupon/usecase/validate_coupon_usecase.dart';
import 'package:e_commerce_application/presentation/cart/bloc/coupon_state.dart';
import 'package:e_commerce_application/service_locator.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit() : super(CouponInitial());

  Future<void> validateCoupon(String code, double orderAmount) async {
    emit(CouponLoading());
    final result = await sl<ValidateCouponUseCase>().call(
      params: ValidateCouponParams(code: code, orderAmount: orderAmount),
    );
    result.fold(
      (error) => emit(CouponValidationFailure(errorMessage: error)),
      (coupon) => emit(CouponValidationSuccess(coupon: coupon)),
    );
  }

  void resetCoupon() {
    emit(CouponInitial());
  }
}
