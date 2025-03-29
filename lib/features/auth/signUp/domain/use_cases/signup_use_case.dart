import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_request_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_response_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/repositories/signup_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupUseCase {
  SignupRepo signupRepo;

  SignupUseCase({required this.signupRepo});

  Future<ApiResult<SignupResponseEntity>> call(SignupRequestEntity signup) {
    return signupRepo.signup(signup);
  }
}
