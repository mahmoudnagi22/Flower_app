import 'package:flowers_app/core/models/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auto_login_repo/auto_login_repo.dart';
import '../auto_login_data_source/auto_login_data_source.dart';
@Injectable(as: AutoLoginRepo)
class AutoLoginRepoImp implements AutoLoginRepo {
  AutoLoginRepoImp(this._autoLoginDataSource);

  final AutoLoginDataSource _autoLoginDataSource;

  @override
  Future<Result> autoLogin() async {
    return await _autoLoginDataSource.autoLogin();
  }
}
