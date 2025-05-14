abstract class LoginCubitState {}

class LoginInitialState extends LoginCubitState {}

class LoginSuccessState extends LoginCubitState {}

class LoginLoadingState extends LoginCubitState {}

class LoginErrorState extends LoginCubitState {
  final String massage;
  LoginErrorState({required this.massage});
}
