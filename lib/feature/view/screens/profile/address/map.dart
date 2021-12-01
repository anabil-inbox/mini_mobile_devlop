import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
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

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  void initState() {
    super.initState();

        profileViewModle.googlePlace = GooglePlace("AIzaSyAozWyP-XVpiaIfqgKprWwwCce5ou46YZE");
       // profileViewModle.currentPostion = LatLng(profileViewModle.latitude, profileViewModle.longitude);
        
  }

  @override
  Widget build(BuildContext context) {
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
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    mapToolbarEnabled: false,
                    myLocationEnabled: false,
                    zoomGesturesEnabled: true,
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
                    initialCameraPosition:
                        GetUtils.isNull(logic.kGooglePlex)
                            ? CameraPosition(
                                target: LatLng(25.36, 51.18),
                                zoom: 10,
                              )
                            : logic.kGooglePlex!,
                    onTap: (lat) {
                      logic.onClickMap(lat);
                    },
                    markers: {logic.mark},
                    onMapCreated: (GoogleMapController newMapController) {
                      if(!logic.controllerCompleter.isCompleted){
                      logic.controllerCompleter
                                  .complete(newMapController);
                                  
                       }
                      

                      logic.mapController = newMapController;
                      logic.update();
                      if (GetUtils.isNull(profileViewModle.currentPostion)) {
                        profileViewModle.getCurrentUserLagAndLong();
                      }else{
                      logic.getCurrentUserLagAndLong(latLng:logic.mark.position);

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
                                    profileViewModle.selectAutocompletePrediction =
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
