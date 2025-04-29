import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';
import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAddressUsecase {
  final AddressRepoContract addressRepoContract;

  UpdateAddressUsecase(this.addressRepoContract);

  Future<void> call(AddressEntity address) async {
    return await addressRepoContract.updateAddress(address);
  }
}
