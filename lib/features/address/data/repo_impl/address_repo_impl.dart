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
  Future<ApiResult> getCurrentAddressInfo() async{
    return await _dataSource.getCurrentAddressInfo();
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
  Future<List<CitiesModel>> getCities() async{
    return await _dataSource.getCities();
  }

  @override
  Future<List<StatesModel>> getStates(String? id) async{
    return await _dataSource.getStates(id);
  }

  @override
  Future<ApiResult> addAddress(Address address,String? id) async{
    return await _dataSource.addAddress(address,id);
  }



}
