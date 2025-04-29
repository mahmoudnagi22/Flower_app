import 'package:injectable/injectable.dart';

import '../../../../core/models/api_result.dart';
import '../../data/models/address.dart';
import '../repo/address_repo.dart';

@injectable
class AddAddressUseCase {
  final AddressRepo _repo;

  AddAddressUseCase(this._repo);

  Future<ApiResult> call(Address address) async {
    return await _repo.addAddress(address);
  }
}
