import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';


import 'map.dart';


class AddAddressScreen extends GetWidget<ProfileViewModle> {
  AddAddressScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: Text("${tr.add_new_address}", style: textStyleAppBarTitle(),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sizeH16!),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: sizeH20,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    controller.tdTitle.text = newValue!;
                    controller.update();
                  },
                  controller: controller.tdTitle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.fill_the_title_correctly}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "${tr.title}"),
                ),
                SizedBox(
                  height: sizeH10,
                ),
                TextFormField(
                  controller: controller.tdBuildingNo,
                  onSaved: (newValue) {
                    controller.tdBuildingNo.text = newValue!;
                    controller.update();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.fill_the_building_no_correctly}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "${tr.building_no}"),
                ),
                SizedBox(
                  height: sizeH10,
                ),
                TextFormField(
                  controller: controller.tdUnitNo,
                  onSaved: (newValue) {
                    controller.tdUnitNo.text = newValue!;
                    controller.update();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.fill_the_unit_no_correctly}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "${tr.unit_no}"),
                ),
                SizedBox(
                  height: sizeH10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    controller.tdZone.text = newValue!;
                    controller.update();
                  },
                  controller: controller.tdZone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.fill_the_zone_correctly}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "${tr.zone}"),
                ),
                SizedBox(
                  height: sizeH10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    controller.tdStreet.text = newValue!;
                    controller.update();
                  },
                  controller: controller.tdStreet,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.fill_the_street_correctly}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "${tr.street}"),
                ),
                SizedBox(
                  height: sizeH10,
                ),
                TextFormField(
                  onTap: (){
                   Get.to(() => MapSample());
                  },
                  onSaved: (newValue) {
                    controller.tdLocation.text = newValue!;
                    controller.update();
                  },
                  controller: controller.tdLocation,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${tr.choose_your_location}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      suffixIcon: SvgPicture.asset(
                        "assets/svgs/location.svg",
                        color: Colors.transparent,
                      ),
                      suffixStyle: TextStyle(color: Colors.transparent),
                      hintText:
                          "${tr.choose_your_location}"),
                ),
                SizedBox(
                  height: sizeH10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    controller.tdExtraDetailes.text = newValue!;
                    controller.update();
                  },
                  controller: controller.tdExtraDetailes,
                  decoration: InputDecoration(
                      hintText:
                          "${tr.extra_details}"),
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

                        print("msg_${controller.isAccepteDefoltLocation}");
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
                            controller.addNewAddress(
                              Address(
                              addressTitle: controller.tdTitle.text,
                              isPrimaryAddress: controller.isAccepteDefoltLocation ? 1 : 0,
                              zone: controller.tdZone.text,
                              streat: controller.tdStreet.text,
                              extraDetails: controller.tdExtraDetailes.text,
                              buildingNo: controller.tdBuildingNo.text,
                              unitNo: controller.tdUnitNo.text,
                              latitude: double.parse(controller.userLat ?? ""),
                              longitude: double.parse(controller.userLong ?? ""),
                            ));
                          }
                        },
                        isExpanded: true
                        );
                  },
                ),
                SizedBox(
                  height: sizeH10,
                ),
              ],
            )),
      ),
    );
  }


}
