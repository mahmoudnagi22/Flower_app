import 'package:equatable/equatable.dart';

enum Status { loading, success, error, initial }

enum ForgotPasswordSuccessType { none, verifyCode, resendCode, resetPassword }

class ForgotPasswordState extends Equatable {
  final Status status;
  final String? message;
  final ForgotPasswordSuccessType successType;

  // Constructor to initialize the state
  const ForgotPasswordState({
    required this.status,
    this.message,
    this.successType = ForgotPasswordSuccessType.none,
  });

  ForgotPasswordState copyWith({
    Status? status,
    String? message,
    ForgotPasswordSuccessType? successType,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      message: message ?? this.message,
      successType: successType ?? this.successType,
    );
  }

  @override
  List<Object?> get props => [status, message, successType];
}
