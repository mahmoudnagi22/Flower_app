import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';

abstract class AddressRepoContract {
  Future<List<AddressEntity>> getAddresses();
  Future<void> deleteAddress(String id);
  Future<void> addAddress(Map<String, dynamic> body);
  Future<void> updateAddress(String id, Map<String, dynamic> body);
}
