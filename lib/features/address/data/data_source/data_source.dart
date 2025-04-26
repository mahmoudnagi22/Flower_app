import '../../../../core/models/api_result.dart';
import '../models/address.dart';
import '../models/cities_model.dart';
import '../models/states_model.dart';

abstract class AddressDataSource {
  Future<ApiResult> getCurrentAddressInfo();

  Future<ApiResult> addAddress(Address address);
  Future<ApiResult> updateAddress(Address address,String id);
  Future<List<CitiesModel>> getCities();
  Future<List<StatesModel>> getStates(String? id);

}
