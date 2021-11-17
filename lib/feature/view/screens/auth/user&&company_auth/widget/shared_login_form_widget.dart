import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/user_model.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button_fingerPinter.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
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
                ? Container(
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
                          SvgPicture.asset("assets/svgs/qatar_flag.svg"),
                          VerticalDivider(),
                          GetBuilder<AuthViewModle>(
                            init: AuthViewModle(),
                            initState: (_) {},
                            builder: (value) {
                              return Text(
                                  "${value.defCountry.prefix == null ? "+972" : value.defCountry.prefix}");
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
                                  return '${AppLocalizations.of(Get.context!)!.fill_your_phone_number}';
                                } else if (value.length != 9) {
                                  return "${AppLocalizations.of(Get.context!)!.phone_number_invalid}";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : type == "${ConstanceNetwork.companyType}"
                    ? Container(
                        child: TextFormField(
                          controller: controller.tdcrNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${AppLocalizations.of(Get.context!)!.fill_cr_number}';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            controller.tdcrNumber.text = val!;
                            controller.update();
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText:
                                  "${AppLocalizations.of(Get.context!)!.cr_number}"),
                        ),
                      )
                    : const SizedBox(),
            SizedBox(height: sizeH28),
            !(GetUtils.isNull(SharedPref.instance.getCurrentUserData()))
                ? 
                Row(
                    children: [
                      GetBuilder<AuthViewModle>(
                        init: AuthViewModle(),
                        initState: (_) {},
                        builder: (logic) {
                          return PrimaryButtonFingerPinter(
                            isExpanded: false,
                            textButton:
                                "${AppLocalizations.of(Get.context!)!.continue_form}",
                            isLoading: controller.isLoading,
                            onClicked: () {
                              if (_formKey.currentState!.validate()) {
                                if (type == "${ConstanceNetwork.userType}") {
                                  controller.signInUser(
                                      user: User(
                                    countryCode:
                                        "${controller.defCountry.prefix!.replaceFirst("+", "")}",
                                    mobile: controller.tdMobileNumber.text,
                                    udid: controller.identifier,
                                    deviceType: controller.deviceType,
                                    fcm: "test",
                                    //  fcm: "${SharedPref.instance.getFCMToken()}",
                                  ));
                                } else if (type ==
                                    "${ConstanceNetwork.companyType}") {
                                  controller.signInCompany(Company(
                                      crNumber: logic.tdcrNumber.text,
                                      udid: controller.identifier,
                                      deviceType: controller.deviceType,
                                      fcm: "",
                                     // fcm:"${SharedPref.instance.getFCMToken()}"
                                      ));
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
                            controller.showFingerPrinterDiloag();
                          },
                          icon:
                              SvgPicture.asset("assets/svgs/finger_pinter.svg"))
                    ],
                  )
                : 
                
                GetBuilder<AuthViewModle>(
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
                                countryCode: "${controller.defCountry.prefix!.replaceAll("+", "")}",
                                mobile: controller.tdMobileNumber.text,
                                udid: controller.identifier,
                                deviceType: controller.deviceType,
                                fcm: "test",
                                // fcm: "${SharedPref.instance.getFCMToken()}",
                              ));
                            } else if (type ==
                                "${ConstanceNetwork.companyType}") {
                              controller.signInCompany(Company(
                                  crNumber: controller.tdcrNumber.text,
                                  udid: controller.identifier,
                                  deviceType: controller.deviceType,
                                  fcm : ""
                                 // fcm: "${SharedPref.instance.getFCMToken()}"
                                  ));
                            }
                          }
                        },
                        isLoading: controller.isLoading,
                        textButton:
                            "${AppLocalizations.of(Get.context!)!.continue_form}",
                      );
                    },
                  ),
     
     
          ],
        ),
      ),
    );
  }
}
