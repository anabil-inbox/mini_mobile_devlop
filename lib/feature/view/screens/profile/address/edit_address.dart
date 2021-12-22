import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'map.dart';

class EditAddressScreen extends StatefulWidget {
  EditAddressScreen({Key? key, required this.address}) : super(key: key);

  final Address address;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  void initState() {
    super.initState();
    profileViewModle.tdTitleEdit.text = widget.address.addressTitle ?? "";
    profileViewModle.tdBuildingNoEdit.text = widget.address.buildingNo ?? "";
    profileViewModle.tdZoneEdit.text = widget.address.zone ?? "";
    profileViewModle.tdExtraDetailesEdit.text =
        widget.address.extraDetails ?? "";
    profileViewModle.tdLocationEdit.text = widget.address.geoAddress ?? "";
    profileViewModle.tdStreetEdit.text = widget.address.streat ?? "";
    profileViewModle.tdBuildingNo.text = widget.address.buildingNo ?? "";
    profileViewModle.tdUnitNoEdit.text = widget.address.unitNo ?? "";
    profileViewModle.isAccepteDefoltLocation =
        widget.address.isPrimaryAddress == 1;
    profileViewModle.latitude = widget.address.latitude ?? 0;
    profileViewModle.longitude = widget.address.longitude ?? 0;
    profileViewModle.mark = Marker(
        position:
            LatLng(widget.address.latitude ?? 0, widget.address.longitude ?? 0),
        markerId: MarkerId(
          LatLng(widget.address.latitude ?? 0, widget.address.longitude ?? 0)
              .toString(),
        ));
    profileViewModle.kGooglePlex = CameraPosition(
        target:
            LatLng(widget.address.latitude ?? 0, widget.address.longitude ?? 0),
        zoom: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          "${tr.edit_address}",
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sizeH16!),
        child: GetBuilder<ProfileViewModle>(
          init: ProfileViewModle(),
          initState: (_) {},
          builder: (controller) {
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeH20,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        controller.tdTitleEdit.text = newValue!;
                        controller.update();
                      },
                      controller: controller.tdTitleEdit,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${tr.fill_the_title_correctly}';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "${tr.title}"),
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.tdBuildingNoEdit,
                      onSaved: (newValue) {
                        controller.tdBuildingNoEdit.text = newValue!;
                        controller.update();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${tr.fill_the_building_no_correctly}';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(hintText: "${tr.building_no}"),
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    TextFormField(
                      controller: controller.tdUnitNoEdit,
                      onSaved: (newValue) {
                        controller.tdUnitNoEdit.text = newValue!;
                        controller.update();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${tr.fill_the_unit_no_correctly}';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "${tr.unit_no}"),
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        controller.tdZoneEdit.text = newValue!;
                        controller.update();
                      },
                      controller: controller.tdZoneEdit,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${tr.fill_the_zone_correctly}';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "${tr.zone}"),
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        controller.tdStreetEdit.text = newValue!;
                        controller.update();
                      },
                      controller: controller.tdStreetEdit,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${tr.fill_the_street_correctly}';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "${tr.street}"),
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => MapSample());
                      },
                      child: TextFormField(
                        onSaved: (newValue) {
                          controller.tdLocationEdit.text = newValue!;
                          controller.update();
                        },
                        controller: controller.tdLocationEdit,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '${tr.choose_your_location}';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabled: false,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                "assets/png/Location.png",
                                width: sizeW15,
                                height: sizeH16,
                              ),
                            ),
                            suffixStyle: TextStyle(color: Colors.transparent),
                            hintText: "${tr.choose_your_location}"),
                      ),
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        controller.tdExtraDetailesEdit.text = newValue!;
                        controller.update();
                      },
                      controller: controller.tdExtraDetailesEdit,
                      decoration:
                          InputDecoration(hintText: "${tr.extra_details}"),
                    ),
                    SizedBox(
                      height: sizeH25,
                    ),
                    InkWell(
                      splashColor: colorTrans,
                      highlightColor: colorTrans,
                      onTap: () {
                        controller.isAccepteDefoltLocation =
                            !controller.isAccepteDefoltLocation;
                        controller.update();
                      },
                      child: GetBuilder<ProfileViewModle>(
                        init: ProfileViewModle(),
                        initState: (_) {},
                        builder: (_) {
                          return Row(
                            children: [
                              controller.isAccepteDefoltLocation
                                  ? SvgPicture.asset("assets/svgs/check.svg")
                                  : SvgPicture.asset("assets/svgs/uncheck.svg"),
                              SizedBox(
                                width: sizeH10,
                              ),
                              Text(
                                "${tr.make_default_address}",
                                style: textStyleHint()!.copyWith(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: sizeH150,
                    ),
                    GetBuilder<ProfileViewModle>(
                      init: ProfileViewModle(),
                      builder: (_) {
                        return PrimaryButton(
                            textButton: "${tr.save}",
                            isLoading: controller.isLoading,
                            onClicked: () {
                              if (_formKey.currentState!.validate()) {
                                controller.editAddress(
                                    Address(
                                      id: widget.address.id,
                                      addressTitle: controller.tdTitleEdit.text,
                                      isPrimaryAddress:
                                          controller.isAccepteDefoltLocation
                                              ? 1
                                              : 0,
                                      zone: controller.tdZoneEdit.text,
                                      streat: controller.tdStreetEdit.text,
                                      extraDetails:
                                          controller.tdExtraDetailesEdit.text,
                                      buildingNo:
                                          controller.tdBuildingNoEdit.text,
                                      geoAddress:
                                          controller.tdLocationEdit.text,
                                      unitNo: controller.tdUnitNoEdit.text,
                                      latitude:
                                          controller.mark.position.latitude,
                                      longitude:
                                          controller.mark.position.longitude,
                                    ),
                                    false);
                              }
                            },
                            isExpanded: true);
                      },
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
