import 'dart:developer';

import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/features/auth/login/data/datasource_impl/login_datasource_impl.dart';
import 'package:flower_app/features/auth/login/data/repository_impl/login_repo_impl.dart';
import 'package:flower_app/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/login_user_response.dart';
import '../../domain/usecases/get_token_usecase.dart';
import 'login_status.dart';

@singleton
class LoginCubit extends Cubit<LoginCubitState>{
  //LoginRepositoryImpl loginRepositoryImpl = LoginRepositoryImpl(loginDataSource: LoginDataSourceImpl());
  LoginUseCase loginUseCase = LoginUseCase(loginRepository:LoginRepositoryImpl(loginDataSource: LoginDataSourceImpl()));
  GetTokenUseCase getTokenUseCase = GetTokenUseCase(loginRepository: LoginRepositoryImpl(loginDataSource: LoginDataSourceImpl()));
  String? token;
  LoginCubit() :super(LoginInitialState());

  login(LoginUserResponse parameters)async{
    emit(LoginLoadingState());
    var response = await  loginUseCase.call(parameters);
    response.fold((l) {
      emit(LoginErrorState(massage:l.failure));
      log("errrror");
    },(r) {
      emit(LoginSuccessState());
      log("Susssss");
    },);
  }

  Future<void> getToken(bool checkboxState) async {
    String? _token = await getTokenUseCase();
    final prefs = await SharedPreferences.getInstance();

    if (_token == null) {
      emit(CheckGetTokenFalseState(checkboxState: checkboxState));
    } else {
      token = _token;
      if (checkboxState) {
        await prefs.setString(AppConstants.tokenKey, token!);
      } else {
        await prefs.remove(AppConstants.tokenKey);
      }
      emit(CheckGetTokenTrueState(checkboxState: checkboxState));
    }
  }

}