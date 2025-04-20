import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/api_result.dart';
import '../../../domain/use_cases/get_user_data.dart';

part 'auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  AutoLoginCubit(this._autoLoginUseCase) : super(AutoLoginInitial());
  final GetUserDataUseCase _autoLoginUseCase;

  Future<void> autoLogin() async {
    emit(AutoLoginLoading());
    final result = await _autoLoginUseCase.call();
    if (result is ApiSuccessResult) {
      emit(AutoLoginSuccess());
    } else if (result is ApiErrorResult) {
      emit(AutoLoginFailure(result.failures!.errorMessage));
    }
  }
}
