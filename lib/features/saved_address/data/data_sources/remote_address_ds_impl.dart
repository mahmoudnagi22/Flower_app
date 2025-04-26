import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/features/saved_address/data/data_sources/remote_address_ds_contract.dart';
import 'package:flower_app/features/saved_address/data/models/address_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteAddressDsContract)
class RemoteAddressDsImpl implements RemoteAddressDsContract {
  final ApiManager apiManager;
  RemoteAddressDsImpl(this.apiManager);

  @override
  Future<void> addAddress(AddressModel address) async {
    await apiManager.patchRequest(
      'addresses',
      address.toJson(),
      headers: {"Authorization": "Bearer ${UserModel.instance.token}"},
    );
  }

  @override
  Future<void> deleteAddress(int addressId) async {
    await apiManager.deleteRequest(
      'addresses/$addressId',
      headers: {"Authorization": "Bearer ${UserModel.instance.token}"},
    );
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    final response = await apiManager.getRequest(
      'addresses',
      headers: {"Authorization": "Bearer ${UserModel.instance.token}"},
    );
    final rawData = response?.data['address'];
    if (rawData == null || rawData is! List) {
      return [];
    }
    return rawData.map((e) => AddressModel.fromJson(e)).toList();
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    await apiManager.patchRequest(
      'addresses/${address.id}',
      address.toJson(),
      headers: {"Authorization": "Bearer ${UserModel.instance.token}"},
    );
  }
}
