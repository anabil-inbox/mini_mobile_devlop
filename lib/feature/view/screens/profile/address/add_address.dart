import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/widgets/blue_plate_form.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/widgets/map_type_form.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/widgets/map_type_item.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';


class AddAddressScreen extends GetWidget<ProfileViewModle> {
  AddAddressScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          "${tr.add_address}",
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
        onBackBtnClick: () {
          controller.clearControllers();
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sizeH16!),
        child: Form(
            key: _formKey,
            child: GetBuilder<ProfileViewModle>(
              builder: (builder) {
                return Column(
                  children: [
                    SizedBox(
                      height: sizeH20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MapTypeItem(buttonText:tr.blue_plate /*"Blue plate"*/),
                        MapTypeItem(buttonText:tr.share_location /*"Share location"*/),
                      ],
                    ),
                    builder.selectedMapType == LocalConstance.bluePlate
                        ? const BluePlateForm()
                        : const MapTypeForm(),
                  
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
                                  ? SvgPicture.asset("assets/svgs/check.svg",color: colorPrimary,)
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
                      initState: (_) {},
                      builder: (_) {
                        return PrimaryButton(
                            textButton: "${tr.save}",
                            isLoading: controller.isLoading,
                            onClicked: () async{

                              if (_formKey.currentState!.validate()) {
                                // if(controller.mark.position.latitude == 25.36){
                                //   var position = await GeolocatorPlatform.instance.getCurrentPosition(
                                //     /*desiredAccuracy: LocationAccuracy.high*/);
                                //   controller.mark =   Marker(markerId: MarkerId(position.toString()) ,
                                //       position:LatLng(position.latitude , position.longitude) );
                                //   await controller.getAddressFromLatLong(LatLng(position.latitude , position.longitude));
                                // }
                                // if(controller.userAreaZone!.numbers!.contains(controller.tdZoneNumber.text.toString())) {

                                var zone = "";
                                if(controller.tdZoneNumber.text.toString().isNotEmpty){
                                  List<AreaZone>? areaZones = ApiSettings.fromJson(jsonDecode(SharedPref.instance.getAppSetting())).areaZones;
                                  if(areaZones != null && areaZones.isNotEmpty){}
                                  areaZones?.forEach((element) {
                                    if(element.numbers != null && element.numbers!.contains(controller.tdZoneNumber.text.toString())){
                                      zone = element.areaZone.toString();
                                    }else{
                                      zone = controller.tdZone.text ;
                                    }
                                  });
                                  // areaZones?.where((element) => element.numbers != null && element.numbers!.contains(controller.tdZoneNumber.text.toString())).first .areaZone.;
                                }else{
                                 zone = controller.tdZone.text ;
                                }

                                  controller.addNewAddress(Address(
                                  addressTitle: controller.tdTitle.text,
                                  isPrimaryAddress:
                                      controller.isAccepteDefoltLocation
                                          ? 1
                                          : 0,
                                  zoneNumber: controller.tdZoneNumber.text.toString()/*??""*/,
                                  zone:zone/*controller.userAreaZone?.id ?? ""*//*:""*/,
                                  streat: controller.tdStreet.text,
                                  extraDetails: controller.tdExtraDetailes.text,
                                  buildingNo: controller.tdBuildingNo.text,
                                  unitNo: controller.tdUnitNo.text,
                                  geoAddress: controller.tdLocation.text,
                                  latitude: controller.mark.position.latitude,
                                  longitude: controller.mark.position.longitude,
                                ));
                                // }else{
                                //   snackError("", tr.fill_the_zone_correctly);
                                // }
                              }
                            },
                            isExpanded: true);
                      },
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
