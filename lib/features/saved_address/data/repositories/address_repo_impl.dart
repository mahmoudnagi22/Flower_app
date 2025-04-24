import 'package:flower_app/features/saved_address/data/data_sources/remote_address_ds_contract.dart';
import 'package:flower_app/features/saved_address/data/models/address_model.dart';
import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';
import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRepoContract)
class AddressRepoImpl implements AddressRepoContract {
  final RemoteAddressDsContract remoteAddressDsContract;
  AddressRepoImpl(this.remoteAddressDsContract);

  @override
  Future<void> addAddress(AddressEntity address) {
    return remoteAddressDsContract.addAddress(
      AddressModel(
        id: address.id,
        address: address.address,
        phoneNumber: address.phoneNumber,
        city: address.city,
        recipientName: address.recipientName,
        area: address.area,
      ),
    );
  }

  @override
  Future<void> deleteAddress(int addressId) {
    return remoteAddressDsContract.deleteAddress(addressId);
  }

  @override
  Future<List<AddressEntity>> getAddresses() {
    return remoteAddressDsContract.getAddresses();
  }

  @override
  Future<void> updateAddress(AddressEntity address) {
    return remoteAddressDsContract.updateAddress(
      AddressModel(
        id: address.id,
        address: address.address,
        phoneNumber: address.phoneNumber,
        city: address.city,
        recipientName: address.recipientName,
        area: address.area,
      ),
    );
  }
}
