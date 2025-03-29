import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/auth/signUp/data/data_sources/remote_signup_data_source_contract.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_request_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/failures.dart';
import '../../domain/entities/signup_response_entity.dart';

@Injectable(as: RemoteSignupDataSourceContract)
class RemoteSignupDataSourceImpl implements RemoteSignupDataSourceContract {
  ApiManager apiManager;

  RemoteSignupDataSourceImpl({required this.apiManager});

  @override
  Future<ApiResult<SignupResponseDto>> signup(
      SignupRequestDto signup) async {
    try {
      var response = await apiManager.signup(signup);
      return response;
    } on DioException catch (e) {
      return ApiErrorResult(
          failures: NetworkError(
              errorMessage: e.message ?? 'An unexpected error occurred'));

    }
  }
}
