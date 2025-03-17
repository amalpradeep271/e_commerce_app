import 'package:e_commerce_application/presentation/cart/bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class PaymentCubit extends Cubit<PaymentState> {
  late Razorpay _razorpay;

  PaymentCubit() : super(PaymentInitial()) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(dynamic amount) {
    var options = {
      'key': 'rzp_test_YourTestKeyHere', // Replace with your test key
      'amount': 5000, // Amount in paise (₹50.00)
      'name': 'Irinjalakuda Khadi',
      'description': 'Transaction',
      // 'prefill': {'contact': '9876543210', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
      emit(PaymentProcessing());
    } catch (e) {
      emit(PaymentFailure('Error: $e'));
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    emit(PaymentSuccess(response.paymentId!));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    emit(PaymentFailure(response.message ?? 'Transaction Failed'));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    emit(PaymentExternalWallet(response.walletName!));
  }

  @override
  Future<void> close() {
    _razorpay.clear();
    return super.close();
  }
}