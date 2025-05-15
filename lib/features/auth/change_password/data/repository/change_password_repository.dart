import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/change_password/data/data_source/contract/change_password_data_source_contract.dart';
import 'package:flower_app/features/auth/change_password/domain/entity/extension.dart';
import 'package:flower_app/features/auth/change_password/domain/entity/request_model_entity/change_password_reqest_enitiy.dart';
import 'package:flower_app/features/auth/change_password/domain/entity/response_model_eintity/change_password_response_enitity.dart';
import 'package:flower_app/features/auth/change_password/domain/repository/change_password_repository_interface.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:ChangePasswordRepository )
class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordContract changePasswordContract;

  ChangePasswordRepositoryImpl({
    required this.changePasswordContract,
  });

  @override
  Future<ApiResult<ChangePasswordResponse>> updatePassword(ChangePasswordRequest request) {

    return changePasswordContract.changePassword(request.toDto());
  }
}
