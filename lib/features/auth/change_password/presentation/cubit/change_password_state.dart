import 'package:equatable/equatable.dart';

enum Status { loading, success, error, initial }

class ChangePasswordState extends Equatable {
  final Status status;
  final String? message;

  // Constructor to initialize the state
  const ChangePasswordState({
    required this.status,
    this.message,
  });

  // A copyWith method to create a new state with modified values
  ChangePasswordState copyWith({
    Status? status,
    String? message,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
