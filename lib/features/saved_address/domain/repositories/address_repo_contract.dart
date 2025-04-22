import 'package:flower_app/features/saved_address/data/models/address_model.dart';

abstract class AddressRepoContract {
  Future<List<AddressModel>> getAddresses();
  Future<void> deleteAddress(AddressModel address);
  Future<void> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
}
