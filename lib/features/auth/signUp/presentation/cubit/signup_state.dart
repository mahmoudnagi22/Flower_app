part of 'signup_cubit.dart';

class SignupState {
  final Status signupState;
  final String? signupError;
  final SignupResponseEntity? signupList;

  const SignupState({
     this.signupState = Status.initial,
    this.signupError,
    this.signupList,
  });

  SignupState copyWith({
    Status? signupState,
    String? signupError,
    SignupResponseEntity? signupList,
  }) {
    return SignupState(
      signupState: signupState ?? this.signupState,
      signupError: signupError ?? this.signupError,
      signupList: signupList ?? this.signupList,
    );
  }
}


