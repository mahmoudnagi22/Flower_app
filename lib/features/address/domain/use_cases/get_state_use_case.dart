import 'package:injectable/injectable.dart';

import '../../data/models/states_model.dart';
import '../repo/address_repo.dart';
@injectable
class GetStateUseCase {
  final AddressRepo _addressRepo;

  GetStateUseCase(this._addressRepo);

  Future<List<StatesModel>> call(String? id) async {
    return await _addressRepo.getStates(id);
  }
}
