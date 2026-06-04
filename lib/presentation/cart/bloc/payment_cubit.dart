import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/helper/cart/cart_helper.dart';
import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/domain/order/entity/order_status_entity.dart';
import 'package:e_commerce_application/domain/order/usecase/order_registration_usecase.dart';
import 'package:e_commerce_application/presentation/cart/bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final Razorpay _razorpay = Razorpay();

  PaymentCubit() : super(PaymentInitial()) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment({
    required double amount,
    required String shippingAddress,
    required List<ProductOrderedEntity> products,
    required dynamic shipping,
    required dynamic tax,
  }) {
    var options = {
      'key': 'rzp_test_2Gu7dLidKZIpTx',
      'amount': (amount * 100).toInt(), // Amount in paisa
      'currency': 'INR',
      'name': 'Khadi Irinjalakuda',
      'description': 'Order Payment',
      'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
      emit(PaymentProcessing());
    } catch (e) {
      emit(PaymentFailure(errorMessage: 'Payment Initialization Failed'));
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    emit(PaymentSuccess(paymentId: response.paymentId!));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    emit(PaymentFailure(errorMessage: 'Payment Failed'));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    emit(PaymentFailure(
        errorMessage: 'External Wallet Used: ${response.walletName}'));
  }

  void placeOrder({
    required String shippingAddress,
    required List<ProductOrderedEntity> products,
    required dynamic shipping,
    required dynamic tax,
    double? totalPrice,
  }) {
    var uuid = const Uuid();
    List<OrderStatusEntity> orderStatusList = [
      OrderStatusEntity(
          createdDate: Timestamp.fromDate(DateTime.now()),
          done: true,
          title: 'Order Placed'),
      OrderStatusEntity(
          createdDate: Timestamp.fromDate(DateTime.now()),
          done: false,
          title: 'Order Confirmed'),
      OrderStatusEntity(
          createdDate: Timestamp.fromDate(DateTime.now()),
          done: false,
          title: 'Shipped'),
      OrderStatusEntity(
          createdDate: Timestamp.fromDate(DateTime.now()),
          done: false,
          title: 'Delivered'),
    ];

    OrderRegistrationReqModel orderModel = OrderRegistrationReqModel(
      code: '#${uuid.v4().substring(0, 7)}',
      products: products,
      createdDate: DateTime.now().toString(),
      itemCount: products.length,
      totalPrice: totalPrice ?? (CartHelper.calculateCartSubtotal(products) + shipping + tax),
      shippingAddress: shippingAddress,
      orderStatus: orderStatusList,
    );

    // Call the use case to save the order
    OrderRegistrationUseCase().call(params: orderModel);

    emit(OrderPlacedSuccessfully());
  }

  @override
  Future<void> close() {
    _razorpay.clear();
    return super.close();
  }
}
