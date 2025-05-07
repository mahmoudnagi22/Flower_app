import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';

abstract class AddressRepoContract {
  Future<List<AddressEntity>> getAddresses();
  Future<void> deleteAddress(int addressId);
  Future<void> addAddress(AddressEntity address);
  Future<void> updateAddress(AddressEntity address);
}
