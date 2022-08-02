import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/location_helper.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  void initState() {
    super.initState();

    profileViewModle.googlePlace =
        GooglePlace("AIzaSyAzBtxE3NluLYNrUajTg9OnG7X_luzESvU");
    // profileViewModle.currentPostion = LatLng(profileViewModle.latitude, profileViewModle.longitude);
    LocationHelper.instance.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        leadingWidth: sizeW50,
        isCenterTitle: true,
        titleWidget: GetBuilder<ProfileViewModle>(
          builder: (_) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      maxLines: 1,
                      minLines: 1,
                      controller: profileViewModle.tdSearchMap,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: scaffoldColor,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              "assets/svgs/search_icon.svg",
                            ),
                          ),
                          hintText: "${tr.search_for_country}"),
                      onChanged: (newVal) {
                        if (newVal.isNotEmpty)
                          profileViewModle.autoCompleteSearch(newVal);
                        profileViewModle.isSearching = true;
                        profileViewModle.update();
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: GetBuilder<ProfileViewModle>(
        init: ProfileViewModle(),
        initState: (_) {},
        builder: (_) {
          return Stack(
            children: [
              GetBuilder<ProfileViewModle>(
                builder: (logic) {
                  return GoogleMap(
                    padding: EdgeInsets.only(
                      bottom: logic.bottomPadding ,
                    ),
                    mapType: /*MapType.normal*/profileViewModle.mapType ,
                     mapToolbarEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomGesturesEnabled: false,
                     zoomControlsEnabled: false,
                    scrollGesturesEnabled: true,
                    rotateGesturesEnabled: false,
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer()))
                      ..add(
                        Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer()),
                      )
                      ..add(
                        Factory<HorizontalDragGestureRecognizer>(
                            () => HorizontalDragGestureRecognizer()),
                      )
                      ..add(
                        Factory<ScaleGestureRecognizer>(
                            () => ScaleGestureRecognizer()),
                      ),
                    initialCameraPosition: GetUtils.isNull(logic.kGooglePlex)
                        ? CameraPosition(
                            target: LatLng(25.226247442192594, 51.53212357058872),
                            zoom: 8,
                          )
                        : logic.kGooglePlex!,
                    onTap: (lat) {
                      logic.onClickMap(lat);
                    },
                    markers: {logic.mark},
                    onMapCreated: (GoogleMapController newMapController) {
                      logic.bottomPadding = sizeH100!;
                      logic.update();
                      if (!logic.controllerCompleter.isCompleted) {
                        logic.controllerCompleter.complete(newMapController);
                      }

                      logic.mapController = newMapController;
                      logic.update();
                      if (GetUtils.isNull(profileViewModle.currentPostion)) {
                        profileViewModle.getCurrentUserLagAndLong();
                      } else {
                        logic.getCurrentUserLagAndLong(
                            latLng: logic.mark.position);
                      }
                    },
                  );
                },
              ),
              Positioned(
                  bottom: sizeH40,
                  right: sizeH18,
                  left: sizeH18,
                  child: PrimaryButton(
                      textButton: "${tr.select}",
                      isLoading: false,
                      onClicked: () async {
                        await profileViewModle.getAddressFromLatLong(
                            profileViewModle.mark.position);
                        profileViewModle.update();
                        Get.back();
                      },
                      isExpanded: true)),
               // if(Platform.isIOS) /// this for zoom in \ out on ios
              PositionedDirectional(
                bottom: sizeH100 ,
                end: sizeW10,
                child: Opacity(
                  opacity: 0.8,
                  child: Card(
                    elevation: 2,
                    child: Container(
                      color: Color(0xFFFAFAFA),
                      width: 40,
                      height: 100,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () async {
                                var currentZoomLevel = await profileViewModle
                                    .mapController
                                    ?.getZoomLevel();

                                currentZoomLevel = currentZoomLevel! + 2;
                                profileViewModle.mapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: profileViewModle.currentPostion!,
                                      zoom: currentZoomLevel,
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(height: 2),
                          IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () async {
                                var currentZoomLevel = await profileViewModle
                                    .mapController
                                    ?.getZoomLevel();
                                currentZoomLevel = currentZoomLevel! - 2;
                                if (currentZoomLevel < 0) currentZoomLevel = 0;
                                profileViewModle.mapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: profileViewModle.currentPostion!,
                                      zoom: currentZoomLevel,
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                end: /*(Platform.isIOS) ? sizeH220 : sizeH140*/sizeH12,
                top: sizeH70,
                child: PhysicalModel(
                  color: colorTextWhite,
                  shape: BoxShape.circle,
                  elevation: 3,
                  child: SizedBox(
                     width: 40,
                    child: ClipOval(
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        children: <Widget>[
                          InkWell(
                              onTap: ()async{
                                profileViewModle.changeMapType();
                              },
                              child: ClipOval(child: Image.asset(profileViewModle.mapType != MapType.normal ? "assets/png/normal_type.png" :"assets/png/satellite_type.png" ))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              (profileViewModle.tdSearchMap.text.isEmpty ||
                      profileViewModle.predictions.isEmpty ||
                      !profileViewModle.isSearching)
                  ? const SizedBox()
                  : Container(
                      height: 200,
                      child: GetBuilder<ProfileViewModle>(
                        builder: (_) {
                          return SingleChildScrollView(
                              child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: profileViewModle.predictions.length,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    profileViewModle.isSearching = false;
                                    profileViewModle.update();
                                    profileViewModle
                                            .selectAutocompletePrediction =
                                        profileViewModle.predictions[index];
                                    profileViewModle.tdSearchMap.text =
                                        profileViewModle
                                            .predictions[index].description
                                            .toString();
                                    await profileViewModle.getDetailsPlace(
                                        profileViewModle
                                            .predictions[index].description!,
                                        profileViewModle
                                            .selectAutocompletePrediction!
                                            .placeId!);

                                    profileViewModle.predictions = [];
                                    profileViewModle.isSearching = false;
                                    profileViewModle.update();
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                profileViewModle
                                                    .predictions[index]
                                                    .description!,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ));
                        },
                      ))
            ],
          );
        },
      ),
    );
  }
}
