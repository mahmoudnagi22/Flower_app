import '../../../../core/models/api_result.dart';
import '../models/cities_model.dart';
import '../models/states_model.dart';

abstract class AddressDataSource {
  Future<ApiResult> getCurrentAddressInfo();
  Future<List<CitiesModel>> getCities();
  Future<List<StatesModel>> getStates(String? id);

}
