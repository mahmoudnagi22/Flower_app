import 'package:injectable/injectable.dart';

import '../../../../core/models/api_result.dart';
import '../repo/address_repo.dart';

@injectable
class GetUserAddressesUseCase {
  final AddressRepo _addressRepo;

  GetUserAddressesUseCase(this._addressRepo);

  Future<ApiResult> call() async {
    return await _addressRepo.getUserAddresses();
  }
}