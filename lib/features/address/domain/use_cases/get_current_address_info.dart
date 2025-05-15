import 'package:injectable/injectable.dart';

import '../../../../core/models/api_result.dart';
import '../repo/address_repo.dart';

@injectable
class GetCurrentAddressInfo {
  final AddressRepo _repo;

  GetCurrentAddressInfo(this._repo);

  Future<ApiResult> call() async {
    return await _repo.getCurrentAddressInfo();
  }
}
