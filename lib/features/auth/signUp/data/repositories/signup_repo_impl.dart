import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/auth/signUp/data/data_sources/remote_signup_data_source_contract.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_request_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/repositories/signup_repo.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/signup_response_entity.dart';
import '../models/signup_request_dto.dart';

@Injectable(as: SignupRepo)
class SignupRepoImpl implements SignupRepo {
  final RemoteSignupDataSourceContract remoteSignupDataSourceContract;

  SignupRepoImpl({required this.remoteSignupDataSourceContract});

  @override
  Future<ApiResult<SignupResponseEntity>> signup(SignupRequestEntity signup) {
    final signupDto = SignupRequestDto(
      firstName: signup.firstName,
      lastName: signup.lastName,
      email: signup.email,
      password: signup.password,
      rePassword: signup.rePassword,
      gender: signup.gender,
      phone: signup.phone,
    );

    return remoteSignupDataSourceContract.signup(signupDto);
  }
}
