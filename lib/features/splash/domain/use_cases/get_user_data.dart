import 'package:injectable/injectable.dart';

import '../../../../core/api_manager/api_result.dart';
import '../auto_login_repo/auto_login_repo.dart';
@injectable
class GetUserDataUseCase {
  final AutoLoginRepo _autoLoginRepo;

  GetUserDataUseCase(this._autoLoginRepo);

  Future<ApiResult> call() async {
    return await _autoLoginRepo.autoLogin();
  }
}