import 'dart:convert';

import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/address/data/models/search_result.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../data_source/data_source.dart';
import '../models/cities_model.dart';
import '../models/states_model.dart';

@Injectable(as: AddressDataSource)
class DataSourceImpl implements AddressDataSource {
  @override
  @override
  Future<ApiResult> getCurrentAddressInfo() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placeMarks.isNotEmpty) {
        final place = placeMarks.first;
        final formattedAddress =
            "${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}"
                .replaceAll(RegExp(r',\s+,'), ',')
                .trim();

        return ApiSuccessResult(
          data: SearchResult(
            address: formattedAddress,
            location: LatLng(position.latitude, position.longitude),
          ),
        );
      }

      return ApiErrorResult(
        failures: CustomError(
          errorMessage: "Failed to find address for location",
        ),
      );
    } catch (e) {
      return ApiErrorResult(
        failures: CustomError(
          errorMessage: "Failed to get position: ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<List<CitiesModel>> getCities() async {
    final String jsonString = await rootBundle.loadString(
      'assets/files/cities.json',
    );
    final data = jsonDecode(jsonString);


    return (data[2]["data"] as List)
        .map<CitiesModel>((e) => CitiesModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<StatesModel>> getStates(String? id) async {
    final String jsonString = await rootBundle.loadString(
      'assets/files/states.json',
    );
    final data = jsonDecode(jsonString);

    id ??= "1";
    return (data[2]["data"] as List)
        .where((e) => e['governorate_id'] == id)
        .map<StatesModel>((e) => StatesModel.fromJson(e))
        .toList();
  }
}
