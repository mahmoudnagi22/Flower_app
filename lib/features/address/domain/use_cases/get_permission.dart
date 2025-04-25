import 'package:injectable/injectable.dart';

import '../repo/address_repo.dart';

@injectable
class GetPermissionUseCase {
  final AddressRepo _repo;

  GetPermissionUseCase(this._repo);

  Future<bool> call() async {
    return _repo.checkPermission();
  }
}
