import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/features/saved_address/data/data_sources/remote_address_ds_contract.dart';
import 'package:flower_app/features/saved_address/data/models/address_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteAddressDsContract)
class RemoteAddressDsImpl implements RemoteAddressDsContract {
  final ApiManager apiManager;
  RemoteAddressDsImpl(this.apiManager);

  @override
  Future<void> addAddress(AddressModel address) async {
    await apiManager.postRequest('addresses', address.toJson());
  }

  @override
  Future<void> deleteAddress(int addressId) async {
    await apiManager.deleteRequest('addresses/$addressId');
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    final response = await apiManager.getRequest('addresses');
    return (response!.data['address'] as List)
        .map((e) => AddressModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    await apiManager.putRequest('addresses/${address.id}', address.toJson());
  }
}
