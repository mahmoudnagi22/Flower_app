import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult {
  final String address;
  final LatLng location;


  SearchResult({required this.address, required this.location});
}
