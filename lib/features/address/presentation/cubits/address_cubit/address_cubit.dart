import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  Future<void> getCurrentAddress() async {
    print("xscsacdscdc");
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

  Widget buildMap(AddressState state) {
    if (state is AddressSuccess) {
      print(state.searchResult.address);
      print("dcjndsncjnsdjkcnjsdcjnsjkdnckjnsdkjcnjksdcn");
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: state.searchResult.location,
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("current"),
              position: state.searchResult.location,
              infoWindow: InfoWindow(title: state.searchResult.address),
            ),
          },
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: false,
          tiltGesturesEnabled: false,
          liteModeEnabled: true,
        ),
      );
    } else if (state is AddressError) {
      return Center(child: Text(state.message));
    } else if (state is AddressLoading) {
      return Center(
        child: CircularProgressIndicator(color: ColorManager.appColor),
      );
    } else if (state is AddressAccessDenied) {
      return Center(
        child: TextButton(
          onPressed: () {},
          child: Text(
            "Allow access to location",
            style: TextStyle(
              color: ColorManager.appColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }
    return Container();
  }

  void updateAddress(SearchResult searchResult) {
    emit(AddressSuccess(searchResult: searchResult));
  }
}
