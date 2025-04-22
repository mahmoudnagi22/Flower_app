import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';

class UpdateAddressUsecase {
  final AddressRepoContract addressRepoContract;

  UpdateAddressUsecase(this.addressRepoContract);

  Future<void> call(String id, Map<String, dynamic> body) async {
    return await addressRepoContract.updateAddress(id, body);
  }
}
