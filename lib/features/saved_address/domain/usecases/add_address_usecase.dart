import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';

class AddAddressUsecase {
  final AddressRepoContract addressRepoContract;

  AddAddressUsecase(this.addressRepoContract);

  Future<void> call(Map<String, dynamic> body) async {
    return await addressRepoContract.addAddress(body);
  }
}
