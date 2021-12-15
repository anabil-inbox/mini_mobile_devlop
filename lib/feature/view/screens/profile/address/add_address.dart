import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'map.dart';

class AddAddressScreen extends GetWidget<ProfileViewModle> {
  AddAddressScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          "${tr.add_address}",
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true, 
        onBackBtnClick: (){
          controller.clearControllers();
          Get.back();
        },       
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
                    if (value == null || value.trim().isEmpty) {
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
                    if (value == null || value.trim().isEmpty) {
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
                    if (value == null || value.trim().isEmpty) {
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
                InkWell(
                  onTap: (){
                    profileViewModle.showZoneBottmSheet();
                  },
                  child: TextFormField(
                    onSaved: (newValue) {
                      controller.tdZone.text = newValue!;
                      controller.update();
                    },
                    controller: controller.tdZone,
                    validator: (value) {
                      
                      if (value == null || value.trim().isEmpty) {
                        return '${tr.fill_the_zone_correctly}';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(padding6!),
                            child: SvgPicture.asset("assets/svgs/down_arrow.svg"),
                          ),
                      //  suffixStyle: TextStyle(color: Colors.transparent),
                      //   suffix: SvgPicture.asset("assets/svgs/down_arrow.svg"),
                        enabled: false,
                        hintText: "${tr.zone}"),
                  ),
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
                    if (value == null || value.trim().isEmpty) {
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
                InkWell(
                  onTap: () {
                    Get.to(() => MapSample());
                  },
                  child: TextFormField(
                    onSaved: (newValue) {
                      controller.tdLocation.text = newValue!;
                      controller.update();
                    },
                    controller: controller.tdLocation,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
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
                            width: 10,
                            height: 10,
                          ),
                        ),
                        // suffixIcon: SvgPicture.asset(
                        //   "assets/svgs/location.svg",
                        //   color: Colors.transparent,
                        // ),
                        suffixStyle: TextStyle(color: Colors.transparent),
                        hintText:
                            "${tr.choose_your_location}"),
                  ),
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
                  height: sizeH100,
                ),
                GetBuilder<ProfileViewModle>(
                  init: ProfileViewModle(),
                  initState: (_){

                  },
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
                              zone: controller.userAreaZone?.id ?? "",
                              streat: controller.tdStreet.text,
                              extraDetails: controller.tdExtraDetailes.text,
                              buildingNo: controller.tdBuildingNo.text,
                              unitNo: controller.tdUnitNo.text,
                              geoAddress: controller.tdLocation.text,
                              latitude: controller.mark.position.latitude,
                              longitude: controller.mark.position.longitude,
                            ));
                          }
                        },
                        isExpanded: true);
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
