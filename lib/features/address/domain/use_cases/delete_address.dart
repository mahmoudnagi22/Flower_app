import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/address/domain/repo/address_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class DeleteAddressUseCase {
  final AddressRepo _repo;

  DeleteAddressUseCase(this._repo);

  Future<ApiResult> call(String addressId) async {
    return await _repo.deleteAddress(addressId);
  }
}