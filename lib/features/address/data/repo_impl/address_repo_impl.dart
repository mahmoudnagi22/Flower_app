import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/address/data/models/address.dart';
import 'package:flower_app/features/address/data/models/cities_model.dart';
import 'package:flower_app/features/address/data/models/states_model.dart';
import 'package:flower_app/features/address/domain/repo/address_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../data_source/data_source.dart';

@Injectable(as: AddressRepo)
class AddressRepoImpl implements AddressRepo {
  final AddressDataSource _dataSource;

  AddressRepoImpl(this._dataSource);

  @override
  Future<ApiResult> getCurrentAddressInfo() {
    return _dataSource.getCurrentAddressInfo();
  }

  @override
  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<List<CitiesModel>> getCities() {
    return _dataSource.getCities();
  }

  @override
  Future<List<StatesModel>> getStates(String? id) {
    return _dataSource.getStates(id);
  }

  @override
  Future<ApiResult> addAddress(Address address) {
    return _dataSource.addAddress(address);
  }

  @override
  Future<ApiResult> deleteAddress(String id) {
    return _dataSource.deleteAddress(id);
  }

  @override
  Future<ApiResult> getUserAddresses() {
    return _dataSource.getUserAddresses();
  }

  @override
  Future<ApiResult> updateAddress(Address address, String id) {
    return _dataSource.updateAddress(address, id);
  }
}
