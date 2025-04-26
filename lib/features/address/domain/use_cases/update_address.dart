import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/address/domain/repo/address_repo.dart';
import 'package:flower_app/features/address/data/models/address.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAddressUseCase {
  final AddressRepo _addressRepo;

  UpdateAddressUseCase(this._addressRepo);

  Future<ApiResult> call(Address address, String id) async {
    return await _addressRepo.updateAddress(address, id);
  }
}