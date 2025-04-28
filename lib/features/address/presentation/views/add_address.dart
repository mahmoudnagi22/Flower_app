import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/features/address/presentation/views/select_location.dart';
import 'package:flower_app/features/address/presentation/views/widgets/build_alert.dart';
import 'package:flower_app/features/address/presentation/views/widgets/build_map.dart';
import 'package:flower_app/features/address/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/cubits/local_cubit/local_cubit.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/widget/validators.dart';
import '../../data/models/address.dart';
import '../../data/models/cities_model.dart';
import '../../data/models/search_result.dart';
import '../../data/models/states_model.dart';
import '../cubits/add_edit_address/add_edit_address_cubit.dart';
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

  bool inSettings = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  List<CitiesModel> cities = [];
  List<StatesModel> states = [];
  String? selectedCityId;
  String? selectedStateId;
  LatLng? currentLocation;

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
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(lang.addressTitle)),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state is AddressSuccess) {
            addressController.text = state.searchResult.address;
          }

          return SingleChildScrollView(
            child: Form(
              key: formState,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          child: BuildMap.buildMap(
                            state,
                            lang,
                            openLocationSettings,
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: () async {
                                if (state is AddressAccessDenied) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BuildAlert(
                                        openLocationSettings:
                                            openLocationSettings,
                                      );
                                    },
                                  );
                                  return;
                                }

                                if (state is! AddressSuccess) {
                                  await cubit.getCurrentAddress();

                                  return;
                                }
                                currentLocation = (state).searchResult.location;

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
                                  currentLocation = result['location'];
                                  AddressCubit.mapController?.animateCamera(
                                    CameraUpdate.newLatLng(result['location']),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      controller: addressController,
                      hintText: lang.addressTitle,
                      validator: AppValidators.validateFullName,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: phoneController,
                      hintText: lang.enterPhoneNumber,
                      validator: AppValidators.validatePhoneNumber,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: recipientController,
                      hintText: lang.recipientNameHint,
                      validator: AppValidators.validateFullName,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedCityId,
                            validator: AppValidators.validateFullName,
                            decoration: InputDecoration(
                              labelText: lang.cityLabel,
                            ),
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
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedStateId,
                            validator: AppValidators.validateFullName,
                            decoration: InputDecoration(
                              labelText: lang.areaLabel,
                            ),
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
                    SizedBox(height: 35),
                    BlocConsumer<AddEditAddressCubit, AddEditAddressState>(
                      listener: (context, state) {
                        if (state is AddEditAddressSuccess) {
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        var cubit = AddEditAddressCubit.get(context);
                        return ElevatedButton(
                          onPressed: () {
                            if (formState.currentState!.validate()) {
                              cubit.addAddress(
                                Address(
                                  street:
                                      "${addressController.text} $selectedStateId",
                                  phone: phoneController.text,
                                  city: selectedCityId!,
                                  lat: currentLocation!.latitude.toString(),
                                  long: currentLocation!.longitude.toString(),
                                  username: recipientController.text,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.appColor,
                          ),
                          child:
                              state is AddEditAddressLoading
                                  ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                  : Text(
                                    lang.saveAddress,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
