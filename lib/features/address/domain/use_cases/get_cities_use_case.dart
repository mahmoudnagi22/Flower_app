import 'package:injectable/injectable.dart';

import '../../data/models/cities_model.dart';
import '../repo/address_repo.dart';
@injectable
class GetCitiesUseCase {
final AddressRepo _addressRepo;
GetCitiesUseCase(this._addressRepo);

Future<List<CitiesModel>> call() async {
  return await _addressRepo.getCities();
}
}