import 'package:flower_app/features/address/data/models/search_result.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressSuccess extends AddressState {
 final SearchResult searchResult;

  AddressSuccess({
   required this.searchResult,
  });
}

class AddressError extends AddressState {
  final String message;
  AddressError(this.message);
}
class AddressAccessDenied extends AddressState {
  final String message;

  AddressAccessDenied(this.message);
}
