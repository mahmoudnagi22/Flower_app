import 'package:dio/dio.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/auth/change_password/data/api_call/api_call.dart';
import 'package:flower_app/features/auth/change_password/data/data_source/contract/change_password_data_source_contract.dart';
import 'package:flower_app/features/auth/change_password/data/dto/requests/change_password_request_dto.dart';
import 'package:flower_app/features/auth/change_password/data/dto/responses/change_password_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordContract)
class ChangePasswordRemoteDataSource implements ChangePasswordContract {
  final ChangePasswordService changePasswordService;

  ChangePasswordRemoteDataSource({
    required this.changePasswordService,
  });

  @override
  Future<ApiResult<ChangePasswordResponseDto>> changePassword(ChangePasswordRequestDto request) async {
    try {
      var response = await changePasswordService.changePassword(request);
      return response;
    } on DioException catch (e) {
      return ApiErrorResult(
          failures: NetworkError(
              errorMessage: e.message ?? 'An unexpected error occurred'),
      );

    }
  }
}
