import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/user_model.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button_fingerPinter.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/sh_util.dart';

class SharedLoginForm extends GetWidget<AuthViewModle> {
  SharedLoginForm({Key? key, required this.type}) : super(key: key);

  final String type;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            type == "${ConstanceNetwork.userType}"
                ? GetBuilder<AuthViewModle>(
                    init: AuthViewModle(),
                    initState: (_) {},
                    builder: (_) {
                      return Container(
                        color: colorTextWhite,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ChooseCountryScreen());
                          },
                          child: Row(
                            textDirection: TextDirection.ltr,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: sizeW18,
                              ),
                              controller.defCountry.name!
                                          .toLowerCase()
                                          .contains("qatar") ||
                                      controller.defCountry.name!.isEmpty
                                  ? SvgPicture.asset(
                                      "assets/svgs/qatar_flag.svg")
                                  : imageNetwork(
                                      url:
                                          "${ConstanceNetwork.imageUrl}${controller.defCountry.flag}",
                                      width: 36,
                                      height: 26),
                              VerticalDivider(),
                              GetBuilder<AuthViewModle>(
                                init: AuthViewModle(),
                                initState: (_) {},
                                builder: (value) {
                                  return Text(
                                    "${value.defCountry.prefix == null ? "+974" : value.defCountry.prefix}",
                                    textDirection: TextDirection.ltr,
                                  );
                                },
                              ),
                              Expanded(
                                child: TextFormField(
                                  textDirection: TextDirection.ltr,
                                  maxLength: 9,
                                  decoration: InputDecoration(counterText: ""),
                                  onSaved: (newValue) {
                                    controller.tdMobileNumber.text =
                                        newValue.toString();
                                    controller.update();
                                  },
                                  controller: controller.tdMobileNumber,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${tr.fill_your_phone_number}';
                                    } else if (value.length != 9) {
                                      return "${tr.phone_number_invalid}";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : type == "${ConstanceNetwork.companyType}"
                    ? Container(
                        child: TextFormField(
                          controller: controller.tdcrNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${tr.fill_cr_number}';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            controller.tdcrNumber.text = val!;
                            controller.update();
                          },
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: "${tr.cr_number}"),
                        ),
                      )
                    : const SizedBox(),
            SizedBox(height: sizeH28),
            !(GetUtils.isNull(SharedPref.instance.getCurrentUserData().id))
                ? Row(
                    children: [
                      GetBuilder<AuthViewModle>(
                        builder: (logic) {
                          return PrimaryButtonFingerPinter(
                            isExpanded: false,
                            textButton: "${tr.continue_form}",
                            isLoading: controller.isLoading,
                            onClicked: () {
                              if (_formKey.currentState!.validate()) {
                                if (type == "${ConstanceNetwork.userType}" &&
                                    SharedPref.instance
                                        .getCurrentUserData()
                                        .crNumber
                                        .toString()
                                        .isEmpty) {
                                  print("msg_in_if");
                                  controller.signInUser(
                                      user: User(
                                    countryCode:
                                        "${controller.defCountry.prefix}",
                                    mobile: controller.tdMobileNumber.text,
                                    udid: controller.identifier,
                                    deviceType: controller.deviceType,
                                    fcm: "${SharedPref.instance.getFCMToken()}",
                                  ));
                                } else if (type ==
                                    "${ConstanceNetwork.companyType}") {
                                  print("msg_in_else");

                                  controller.signInCompany(Company(
                                      crNumber: logic.tdcrNumber.text,
                                      udid: controller.identifier,
                                      deviceType: controller.deviceType,
                                      fcm:
                                          "${SharedPref.instance.getFCMToken()}"));
                                }
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(width: sizeW10),
                      IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            controller.logInWithTouchId();
                          },
                          icon:
                              SvgPicture.asset("assets/svgs/finger_pinter.svg"))
                    ],
                  )
                : GetBuilder<AuthViewModle>(
                    init: AuthViewModle(),
                    initState: (_) {},
                    builder: (_) {
                      return PrimaryButtonFingerPinter(
                        isExpanded: true,
                        onClicked: () {
                          if (_formKey.currentState!.validate()) {
                            if (type == "${ConstanceNetwork.userType}") {
                              controller.signInUser(
                                  user: User(
                                countryCode: "${controller.defCountry.prefix}",
                                mobile: controller.tdMobileNumber.text,
                                udid: controller.identifier,
                                deviceType: controller.deviceType,
                                fcm: "${SharedPref.instance.getFCMToken()}",
                              ));
                            } else if (type ==
                                "${ConstanceNetwork.companyType}") {
                              controller.signInCompany(Company(
                                  crNumber: controller.tdcrNumber.text,
                                  udid: controller.identifier,
                                  deviceType: controller.deviceType,
                                  fcm: "${SharedPref.instance.getFCMToken()}"));
                            }
                          }
                        },
                        isLoading: controller.isLoading,
                        textButton: "${tr.continue_form}",
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
