import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAddressUsecase {
  final AddressRepoContract addressRepoContract;

  DeleteAddressUsecase(this.addressRepoContract);

  Future<void> call(String addressId) async {
    return await addressRepoContract.deleteAddress(addressId);
  }
}
