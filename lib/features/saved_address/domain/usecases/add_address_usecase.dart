import 'package:flower_app/features/saved_address/data/models/address_model.dart';
import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUsecase {
  final AddressRepoContract addressRepoContract;

  AddAddressUsecase(this.addressRepoContract);

  Future<void> call(AddressModel address) async {
    return await addressRepoContract.addAddress(address);
  }
}
