import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class MapSample extends GetWidget<ProfileViewModle> {
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
                    height: 45,
                 clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      controller: controller.tdSearchMap,
                      decoration: InputDecoration(
                          filled: true,
                          // contentPadding: EdgeInsets.only(top: 5,bottom: 5),
                          fillColor: scaffoldColor,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              "assets/svgs/search_icon.svg",
                            ),
                          ),
                          hintText: "${tr.search_for_country}"),
                      onChanged: (newVal) {
                        print("msg_new_val $newVal");
                        if (newVal.isNotEmpty)
                          controller.autoCompleteSearch(newVal);
                        controller.update();
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
                builder: (_) {
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: controller.kGooglePlex,
                    onTap: (lat) {
                      controller.onClickMap(lat);
                    },
                    markers: {controller.mark},
                    onMapCreated: (GoogleMapController mapController) {
                      controller.controllerCompleter.complete(mapController);
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
                        await controller
                            .getAddressFromLatLong(controller.mark.position);
                        controller.update();
                        Get.back();
                      },
                      isExpanded: true)),
              (controller.tdSearchMap.text.isEmpty ||
                      controller.predictions.isEmpty)
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
                              itemCount: controller.predictions.length,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    print("log_clicked_:");
                                    controller.selectAutocompletePrediction =
                                        controller.predictions[index];
                                    print(
                                        "log_choose_: ${controller.predictions[index].placeId}");
                                    print(
                                        "log_choose_: ${controller.predictions[index].description}");
                                    print(
                                        "log_choose_: ${controller.predictions[index].types}");
                                    await controller.getDetailsPlace(
                                        controller
                                            .predictions[index].description!,
                                        controller.selectAutocompletePrediction!
                                            .placeId!);

                                    controller.predictions = [];
                                    controller.update();
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
                                                controller.predictions[index]
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
