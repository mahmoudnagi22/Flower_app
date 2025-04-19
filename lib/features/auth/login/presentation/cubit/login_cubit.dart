import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/login/data/datasource_impl/login_datasource_impl.dart';
import 'package:flower_app/features/auth/login/data/model/login_user_response.dart';
import 'package:flower_app/features/auth/login/data/repository_impl/login_repo_impl.dart';
import 'package:flower_app/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_status.dart';

@singleton
class LoginCubit extends Cubit<LoginCubitState> {
  static LoginCubit get(context) => BlocProvider.of(context);
  LoginUseCase loginUseCase = LoginUseCase(
    loginRepository: LoginRepositoryImpl(
      loginDataSource: LoginDataSourceImpl(),
    ),
  );

  LoginCubit() : super(LoginInitialState());

  login(LoginUserResponse parameters) async {
    emit(LoginLoadingState());
    var response = await loginUseCase.call(parameters);
    switch (response) {
      case ApiSuccessResult():
        emit(LoginSuccessState());

      case ApiErrorResult():
        emit(LoginErrorState(massage: response.failures!.errorMessage));
    }
  }
}
