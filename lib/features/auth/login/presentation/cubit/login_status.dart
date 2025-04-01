abstract class LoginCubitState{}

class LoginInitialState extends LoginCubitState{}
class LoginSuccessState extends LoginCubitState{}
class LoginLoadingState extends LoginCubitState{}
class LoginErrorState extends LoginCubitState{
  final String massage;
  LoginErrorState({required this.massage});
}
class CheckGetTokenTrueState extends LoginCubitState{
  bool checkboxState;
  CheckGetTokenTrueState({required this.checkboxState});
}
class CheckGetTokenFalseState extends LoginCubitState{
  bool checkboxState;
  CheckGetTokenFalseState({required this.checkboxState});
}
