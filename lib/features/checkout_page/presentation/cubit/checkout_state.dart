import 'package:equatable/equatable.dart';

enum Status { initial, loading, success, error ,navigate}
enum PaymentType { cash, credit }

class CheckoutState extends Equatable {
  final Status status;
  final String message;
  final PaymentType paymentType;
  final String route;

  const CheckoutState({
    this.status = Status.initial,
    this.message = '',
    this.route='',
    this.paymentType = PaymentType.cash,
  });

  CheckoutState copyWith({
    Status? status,
    String? message,
    PaymentType? paymentType,
    String ? route,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      message: message ?? this.message,
      route: route??this.route,
      paymentType: paymentType ?? this.paymentType,
    );
  }

  @override
  List<Object?> get props => [status, message, paymentType,route];

  @override
  String toString() =>
      'CheckoutState(status: $status, message: $message, paymentType: $paymentType,route:$route)';
}
