abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String paymentId;
  PaymentSuccess(this.paymentId);
}

class PaymentFailure extends PaymentState {
  final String error;
  PaymentFailure(this.error);
}

class PaymentExternalWallet extends PaymentState {
  final String walletName;
  PaymentExternalWallet(this.walletName);
}