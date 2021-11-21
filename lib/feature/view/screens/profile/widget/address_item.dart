import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/edit_address.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

// ignore: must_be_immutable
class AddressItem extends StatelessWidget {
  AddressItem({Key? key, required this.address}) : super(key: key);

  ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();
  final Address address;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModle>(
      init: ProfileViewModle(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: sizeH100,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: colorTextWhite,
                  borderRadius: BorderRadius.circular(6)),
              child: Stack(
                children: [
                  PositionedDirectional(
                      top: sizeH34,
                      start: sizeH20,
                      child: address.isPrimaryAddress == 1
                          ? InkWell(
                              onTap: () {
                                profileViewModle.editAddress(Address(
                                  id: address.id,
                                  addressTitle: address.addressTitle,
                                  geoAddress: address.geoAddress,
                                  extraDetails: address.extraDetails,
                                  buildingNo: address.buildingNo,
                                  zone: address.zone,
                                  streat: address.streat,
                                  unitNo: address.unitNo,
                                  latitude: address.latitude,
                                  longitude: address.longitude,
                                  isPrimaryAddress: 0,
                                ));
                              },
                              child: SvgPicture.asset("assets/svgs/check.svg"))
                          : InkWell(
                              onTap: () {
                                profileViewModle.editAddress(Address(
                                  id: address.id,
                                  addressTitle: address.addressTitle,
                                  geoAddress: address.geoAddress,
                                  extraDetails: address.extraDetails,
                                  buildingNo: address.buildingNo,
                                  zone: address.zone,
                                  streat: address.streat,
                                  unitNo: address.unitNo,
                                  latitude: address.latitude,
                                  longitude: address.longitude,
                                  isPrimaryAddress: 1,
                                ));
                              },
                              child:
                                  SvgPicture.asset("assets/svgs/uncheck.svg"))),
                  PositionedDirectional(
                    start: sizeH54,
                    top: sizeH25,
                    child: Text("${address.addressTitle}"),
                  ),
                  PositionedDirectional(
                    top: sizeH54,
                    start: sizeH54,
                    child: Text(
                        "${address.streat} ${address.zone} ${address.buildingNo}"),
                  ),
                  PositionedDirectional(
                    top: sizeH12,
                    end: sizeH12,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              profileViewModle.deleteAddress(address.id!);
                              profileViewModle.userAddress.removeWhere(
                                  (element) => element.id == address.id);
                              profileViewModle.update();
                            },
                            child: SvgPicture.asset("assets/svgs/delete.svg")),
                        SizedBox(
                          width: sizeW10,
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(() => EditAddressScreen(address: address));
                            },
                            child: SvgPicture.asset("assets/svgs/update.svg"))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: sizeH10,
            )
          ],
        );
      },
    );
  }
}
