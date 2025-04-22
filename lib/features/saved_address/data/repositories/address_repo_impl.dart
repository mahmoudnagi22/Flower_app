import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';
import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';

class AddressRepoImpl implements AddressRepoContract {
  @override
  Future<void> addAddress(Map<String, dynamic> body) {
    // TODO: implement addAddress
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAddress(String id) {
    // TODO: implement deleteAddress
    throw UnimplementedError();
  }

  @override
  Future<List<AddressEntity>> getAddresses() {
    // TODO: implement getAddresses
    throw UnimplementedError();
  }

  @override
  Future<void> updateAddress(String id, Map<String, dynamic> body) {
    // TODO: implement updateAddress
    throw UnimplementedError();
  }
}
