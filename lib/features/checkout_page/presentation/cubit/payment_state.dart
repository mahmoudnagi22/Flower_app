
enum PaymentMethod { cash, credit }

class PaymentMethodState {
  final PaymentMethod paymentMethod;

  const PaymentMethodState({required this.paymentMethod});

  PaymentMethodState copyWith({PaymentMethod? paymentMethod}) {
    return PaymentMethodState(
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}