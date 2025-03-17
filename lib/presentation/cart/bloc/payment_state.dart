abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String paymentId;
  PaymentSuccess({required this.paymentId});
}

class PaymentFailure extends PaymentState {
  final String errorMessage;
  PaymentFailure({required this.errorMessage});
}

class OrderPlacedSuccessfully extends PaymentState {}