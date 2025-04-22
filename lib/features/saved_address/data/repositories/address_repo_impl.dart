import 'package:flower_app/features/saved_address/data/data_sources/remote_address_ds_contract.dart';
import 'package:flower_app/features/saved_address/data/models/address_model.dart';
import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRepoContract)
class AddressRepoImpl implements AddressRepoContract {
  final RemoteAddressDsContract remoteAddressDsContract;
  AddressRepoImpl(this.remoteAddressDsContract);

  @override
  Future<void> addAddress(AddressModel address) {
    return remoteAddressDsContract.addAddress(address);
  }

  @override
  Future<void> deleteAddress(AddressModel address) {
    return remoteAddressDsContract.deleteAddress(address);
  }

  @override
  Future<List<AddressModel>> getAddresses() {
    return remoteAddressDsContract.getAddresses();
  }

  @override
  Future<void> updateAddress(AddressModel address) {
    return remoteAddressDsContract.updateAddress(address);
  }
}
