import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';

class DeleteAddressUsecase {
  final AddressRepoContract addressRepoContract;

  DeleteAddressUsecase(this.addressRepoContract);

  Future<void> call(String id) async {
    return await addressRepoContract.deleteAddress(id);
  }
}
