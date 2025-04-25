import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/features/address/presentation/views/select_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/cubits/local_cubit/local_cubit.dart';
import '../../data/models/cities_model.dart';
import '../../data/models/search_result.dart';
import '../../data/models/states_model.dart';
import '../cubits/address_cubit/address_cubit.dart';
import '../cubits/address_cubit/address_state.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen>
    with WidgetsBindingObserver {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  GoogleMapController? mapController;
  bool inSettings = false;

  List<CitiesModel> cities = [];
  List<StatesModel> states = [];
  String? selectedCityId;
  String? selectedStateId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    var cubit = AddressCubit.get(context);
    cubit.getCurrentAddress();

    cities = await cubit.getCities();

    if (cities.isNotEmpty) {
      selectedCityId = cities.first.id;
      await _loadStatesForCity(selectedCityId);
    }
  }

  Future<void> _loadStatesForCity(String? cityId) async {
    states = await AddressCubit.get(context).getStates(cityId);
    selectedStateId = states.isNotEmpty ? states.first.id : null;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && inSettings) {
      AddressCubit.get(context).getCurrentAddress();
      inSettings = false;
    }
  }

  void openLocationSettings() async {
    inSettings = true;
    await Geolocator.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AddressCubit.get(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Address")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            print(state);
            if (state is AddressSuccess) {
              addressController.text = state.searchResult.address;
            }

            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: buildMap(state),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () async {
                            print("Map tapped. Current state: $state");

                            if (state is AddressAccessDenied) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: const Text("Location Access Denied"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          openLocationSettings();
                                        },
                                        child: const Text("Allow"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: ColorManager.appColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }

                            if (state is! AddressSuccess) {
                              await cubit.getCurrentAddress();
                              return;
                            }

                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => SelectLocationScreen(
                                      initialPosition:
                                          (state).searchResult.location,
                                    ),
                              ),
                            );

                            if (result != null) {
                              cubit.updateAddress(
                                SearchResult(
                                  address: result['address'],
                                  location: result['location'],
                                ),
                              );

                              mapController?.animateCamera(
                                CameraUpdate.newLatLng(result['location']),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: "Address"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: "Phone number"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: recipientController,
                  decoration: const InputDecoration(
                    labelText: "Recipient name",
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedCityId,
                        decoration: const InputDecoration(labelText: "City"),
                        items:
                            cities.map((city) {
                              return DropdownMenuItem<String>(
                                value: city.id,
                                child: Text(
                                  LocalizationCubit.get(
                                            context,
                                          ).state.language ==
                                          'en'
                                      ? city.cityNameEn
                                      : city.cityNameAr,
                                ),
                              );
                            }).toList(),
                        onChanged: (String? cityId) {
                          setState(() {
                            selectedCityId = cityId;
                            selectedStateId = null;
                            states = [];
                          });
                          _loadStatesForCity(cityId);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedStateId,
                        decoration: const InputDecoration(labelText: "Area"),
                        items:
                            states.map((state) {
                              return DropdownMenuItem<String>(
                                value: state.id,
                                child: Text(
                                  LocalizationCubit.get(
                                            context,
                                          ).state.language ==
                                          'en'
                                      ? state.stateNameEn
                                      : state.stateNameAr,
                                ),
                              );
                            }).toList(),
                        onChanged: (String? stateId) {
                          setState(() {
                            selectedStateId = stateId;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildMap(AddressState state) {
    if (state is AddressSuccess) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          onMapCreated: (controller) {
            mapController = controller;
          },
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
          onPressed: openLocationSettings,
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
}
