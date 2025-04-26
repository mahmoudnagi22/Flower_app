import 'dart:async';

import 'package:flower_app/features/address/presentation/views/select_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/search_result.dart';
import '../cubits/address_cubit/address_cubit.dart';

class SelectLocationScreen extends StatefulWidget {
  final LatLng initialPosition;

  const SelectLocationScreen({super.key, required this.initialPosition});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  GoogleMapController? mapController;
  late LatLng selectedPosition;
  String currentAddress = "";
  bool isLoading = false;
  bool showResults = true;
  final searchController = TextEditingController();
  List<SearchResult> searchResults = [];
  bool isSearching = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    selectedPosition = widget.initialPosition;
    _updateAddress(selectedPosition.latitude, selectedPosition.longitude);
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.length > 2) {
        _getSearchResults(searchController.text);
      } else {
        setState(() {
          searchResults = [];
        });
      }
    });
  }

  Future<void> _getSearchResults(String query) async {
    if (query.isEmpty) return;

    setState(() {
      isSearching = true;
      searchResults = [];
    });

    try {
      List<Location> locations = await locationFromAddress(query);
      List<SearchResult> results = [];
      for (var location in locations) {
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            location.latitude,
            location.longitude,
          );

          if (placemarks.isNotEmpty) {
            for (var placemark in placemarks) {
              String street = placemark.street ?? '';
              String locality = placemark.locality ?? '';
              String subLocality = placemark.subLocality ?? '';
              String adminArea = placemark.administrativeArea ?? '';
              String country = placemark.country ?? '';
              List<String> addressParts =
                  [
                    street,
                    subLocality,
                    locality,
                    adminArea,
                    country,
                  ].where((part) => part.isNotEmpty).toList();

              String address = addressParts.join(", ");
              bool isDuplicate = results.any(
                (result) =>
                    result.address == address &&
                    result.location.latitude == location.latitude &&
                    result.location.longitude == location.longitude,
              );

              if (!isDuplicate && address.isNotEmpty) {
                results.add(
                  SearchResult(
                    address: address,
                    location: LatLng(location.latitude, location.longitude),
                  ),
                );
              }
            }
          }
        } catch (e) {
          print("Error processing location: $e");
        }
      }

      setState(() {
        searchResults = results;
        isSearching = false;
      });
    } catch (e) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
    }
  }

  Future<void> _updateAddress(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          currentAddress =
              "${place.street}, ${place.locality}, ${place.administrativeArea}";
        });
      }
    } catch (e) {
      setState(() {
        currentAddress = "Unknown Location";
      });
    }
  }

  void _onMapTap(LatLng position) {
    setState(() {
      selectedPosition = position;
      isLoading = true;
      searchResults = [];
    });
    _updateAddress(position.latitude, position.longitude).then((_) {
      setState(() => isLoading = false);
    });
  }

  void _getCurrentLocation() async {
    setState(() => isLoading = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      final pos = await Geolocator.getCurrentPosition();
      final newLatLng = LatLng(pos.latitude, pos.longitude);

      setState(() {
        selectedPosition = newLatLng;
        searchResults = [];
      });

      mapController?.animateCamera(CameraUpdate.newLatLng(newLatLng));

      await _updateAddress(pos.latitude, pos.longitude);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to get current location")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _selectSearchResult(SearchResult result) {
    setState(() {
      isLoading = true;
      searchResults = [];
      searchController.text = result.address;
      showResults = false;
      selectedPosition = result.location;
    });

    mapController?.animateCamera(CameraUpdate.newLatLng(result.location));

    _updateAddress(result.location.latitude, result.location.longitude).then((
      _,
    ) {
      setState(() => isLoading = false);
    });
  }

  void _useLocation() {
    Navigator.pop(context, {
      "address": currentAddress,
      "location": selectedPosition,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedPosition,
              zoom: 15,
            ),

            onMapCreated: (controller) => mapController = controller,
            onTap: _onMapTap,

            markers: {
              Marker(
                markerId: const MarkerId("selected"),
                position: selectedPosition,
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) => showResults = true,
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search for a location",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon:
                          isSearching
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: Center(
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.pink,
                                    ),
                                  ),
                                ),
                              )
                              : searchController.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {
                                    searchResults = [];
                                  });
                                },
                                color: Colors.grey,
                              )
                              : null,
                    ),
                  ),
                ),
                if (searchResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 8),
                      ],
                    ),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child:
                        showResults
                            ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                final result = searchResults[index];
                                return ListTile(
                                  title: Text(
                                    result.address,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: Colors.pink,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  dense: true,
                                  onTap: () => _selectSearchResult(result),
                                );
                              },
                            )
                            : SizedBox(),
                  ),
              ],
            ),
          ),
          Positioned(
            top: searchResults.isEmpty ? 80 : null,
            bottom: searchResults.isEmpty ? null : 90,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  isLoading
                      ? const Center(child: LinearProgressIndicator())
                      : Text(
                        currentAddress,
                        style: const TextStyle(fontSize: 14),
                      ),
            ),
          ),
          Positioned(
            bottom: 90,
            right: 16,
            child: FloatingActionButton(
              onPressed: isLoading ? null : _getCurrentLocation,
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location, color: Colors.pink),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : _useLocation,
              icon: const Icon(Icons.location_on),
              label: Text(
                isLoading ? "Loading..." : "Use this location",
                style: const TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
