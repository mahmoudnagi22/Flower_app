import 'package:equatable/equatable.dart';

enum Status { initial, loading, success, error }
enum PaymentType { cash, credit }

class CheckoutState extends Equatable {
  final Status status;
  final String message;
  final PaymentType paymentType;

  const CheckoutState({
    this.status = Status.initial,
    this.message = '',
    this.paymentType = PaymentType.cash,
  });

  CheckoutState copyWith({
    Status? status,
    String? message,
    PaymentType? paymentType,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      message: message ?? this.message,
      paymentType: paymentType ?? this.paymentType,
    );
  }

  @override
  List<Object?> get props => [status, message, paymentType];

  @override
  String toString() =>
      'CheckoutState(status: $status, message: $message, paymentType: $paymentType)';
}
