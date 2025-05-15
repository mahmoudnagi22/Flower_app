import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/models/api_result.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../data/models/cities_model.dart';
import '../../../data/models/search_result.dart';
import '../../../data/models/states_model.dart';
import '../../../domain/use_cases/get_cities_use_case.dart';
import '../../../domain/use_cases/get_current_address_info.dart';
import '../../../domain/use_cases/get_permission.dart';
import '../../../domain/use_cases/get_state_use_case.dart';
import 'address_state.dart';
@injectable
class AddressCubit extends Cubit<AddressState> {
  AddressCubit(
    this._getCurrentAddress,
    this._getPermissionUseCase,
    this._getCitiesUseCase,
    this._getStateUseCase,
  ) : super(AddressInitial());

  final GetCurrentAddressInfo _getCurrentAddress;
  final GetPermissionUseCase _getPermissionUseCase;
  final GetCitiesUseCase _getCitiesUseCase;
  final GetStateUseCase _getStateUseCase;

  static AddressCubit get(context) => BlocProvider.of(context);
  static GoogleMapController? mapController;
  Future<void> getCurrentAddress() async {

    if (await _getPermissionUseCase.call()) {
      emit(AddressLoading());
      final address = await _getCurrentAddress.call();

      if (address is ApiSuccessResult) {
        emit(AddressSuccess(searchResult: address.data));
      } else if (address is ApiErrorResult) {
        emit(AddressError(address.failures.errorMessage));
      }
    } else {
      emit(AddressAccessDenied("allow access to location"));
    }
  }

  Future<List<CitiesModel>> getCities() async {
    return await _getCitiesUseCase.call();
  }

  Future<List<StatesModel>> getStates(String? id) async {
    return await _getStateUseCase.call(id);
  }



  void updateAddress(SearchResult searchResult) {
    emit(AddressInitial());
    emit(AddressSuccess(searchResult: searchResult));
  }
}
