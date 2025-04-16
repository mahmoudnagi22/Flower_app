import '../../../../core/models/result.dart';

abstract class AutoLoginDataSource {
  Future<Result> autoLogin();
}
