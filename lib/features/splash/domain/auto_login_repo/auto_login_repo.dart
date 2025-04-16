import 'package:flowers_app/core/models/result.dart';

abstract class AutoLoginRepo {
  Future<Result> autoLogin();
}