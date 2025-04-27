import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/l10n/app_localizations.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../cubits/address_cubit/address_cubit.dart';
import '../../cubits/address_cubit/address_state.dart';

class BuildMap {
 static Widget buildMap(AddressState state, AppLocalizations lang, void Function()? openLocationSettings) {
    if (state is AddressSuccess) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          onMapCreated: (controller) {
            AddressCubit.mapController = controller;

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
            lang.allowLocationAccess,
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