import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';
import 'package:flower_app/features/saved_address/domain/repositories/address_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddressesUsecase {
  final AddressRepoContract addressRepoContract;

  GetAddressesUsecase(this.addressRepoContract);

  Future<List<AddressEntity>> call() async {
    return await addressRepoContract.getAddresses();
  }
}
