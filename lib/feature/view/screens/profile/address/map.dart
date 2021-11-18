import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';

class MapScreen extends GetWidget<ProfileViewModle> {
  const MapScreen({Key? key}) : super(key: key);


  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModle>(
      builder: (logic) {
        return PlacePicker(
          apiKey: "AIzaSyAozWyP-XVpiaIfqgKprWwwCce5ou46YZE",
          onPlacePicked: (result) {
            logic.userLat = result.geometry!.location.lat.toString();
            logic.userLong = result.geometry!.location.lng.toString();
            logic.tdLocation.text = result.formattedAddress ?? "";
            logic.update();
            Get.back();
          },
          initialPosition: GetUtils.isNull(controller.userLat) ? LatLng(25.5, 51.25) : LatLng(double.parse(controller.userLat!), double.parse(controller.userLong!)),
          useCurrentLocation: true,
          
        );
      },
    );
  }
}
