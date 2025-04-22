import 'package:flower_app/features/saved_address/data/models/address_model.dart';

abstract class RemoteAddressDsContract {
  Future<List<AddressModel>> getAddresses();
  Future<void> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> deleteAddress(String addressId);
}
