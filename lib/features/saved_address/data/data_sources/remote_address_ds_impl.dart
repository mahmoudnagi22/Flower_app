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
    await apiManager.postRequest('addresses', {
      "street": address.street,
      "phone": address.phone,
      "city": address.city,
      "lat": address.lat,
      "long": address.long,
      "username": address.username,
    });
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await apiManager.deleteRequest('addresses/$addressId');
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    final response = await apiManager.getRequest('addresses');
    final List addressesJson = response?.data['addresses'];
    return addressesJson.map((e) => AddressModel.fromJson(e)).toList();
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    await apiManager.putRequest('addresses/${address.id}', {
      "street": address.street,
      "phone": address.phone,
      "city": address.city,
      "lat": address.lat,
      "long": address.long,
      "username": address.username,
    });
  }
}
