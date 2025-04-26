import '../../../../core/models/api_result.dart';
import '../../data/models/address.dart';
import '../../data/models/cities_model.dart';
import '../../data/models/states_model.dart';

abstract class AddressRepo {
  Future<ApiResult> getCurrentAddressInfo();
  Future<bool> checkPermission();
  Future<List<CitiesModel>> getCities();
  Future<List<StatesModel>> getStates(String? id);


  Future<ApiResult> addAddress(Address address);
  Future<ApiResult> updateAddress(Address address,String id);

}