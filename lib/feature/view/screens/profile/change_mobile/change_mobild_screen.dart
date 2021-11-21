import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/widget/header_code_verfication_widget.dart';
import 'package:inbox_clients/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_clients/feature/view/screens/profile/change_mobile/verfication_change_mobile.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/sh_util.dart';

class ChangeMobileScreen extends StatelessWidget {
   ChangeMobileScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: GetBuilder<AuthViewModle>(
        init: AuthViewModle(),
        initState: (_) {},
        builder: (logic) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderCodeVerfication(),
                SizedBox(height: sizeH25),
                Text("${AppLocalizations.of(context)!.change_mobile_number}"),
                SizedBox(height: sizeH10),
                Text(
                    "${AppLocalizations.of(context)!.what_is_your_new_phone_number}"),
                SizedBox(
                  height: sizeH22,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeH16!),
                  child: Form(
                    key: _formKey,
                      child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.put(AuthViewModle());
                          Get.to(() => ChooseCountryScreen());
                        },
                        child: Container(
                          height: sizeH60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: colorTextWhite,
                          ),
                          child: GetBuilder<AuthViewModle>(
                            builder: (value) {
                              return Row(
                          textDirection: TextDirection.ltr,
                          children: [
                            SizedBox(
                              width: sizeW18,
                            ),
                            value.defCountry.name!
                                        .toLowerCase()
                                        .contains("qatar") ||
                                    value.defCountry.name!.isEmpty
                                ? SvgPicture.asset("assets/svgs/qatar_flag.svg")
                                : imageNetwork(
                                    url: "${ConstanceNetwork.imageUrl}${value.defCountry.flag}",
                                    width: 36,
                                    height: 26),
                            VerticalDivider(),
                            GetBuilder<AuthViewModle>(
                              init: AuthViewModle(),
                              initState: (_) {},
                              builder: (value) {
                                return Text(
                                  "${value.defCountry.prefix == null || value.defCountry.prefix!.isEmpty ? "+974" : value.defCountry.prefix}",
                                  textDirection: TextDirection.ltr,
                                );
                              },
                            ),
                            Expanded(
                              child: TextFormField(
                                textDirection: TextDirection.ltr,
                                maxLength: 9,
                                onSaved: (newValue) {
                                  logic.tdMobileNumber.text =
                                      newValue.toString();
                                  logic.update();
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                ),
                                controller: logic.tdMobileNumber,
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
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeH31,
                ),
                PrimaryButton(
                    textButton: "${tr.save}",
                    isLoading: false,
                    onClicked: () async {
                      if(_formKey.currentState!.validate()){
                       await logic.reSendVerficationCode(
                        id: SharedPref.instance.getCurrentUserData().id,
                        target: "sms",
                        mobileNumber: "${logic.tdMobileNumber.text}",
                        countryCode: logic.defCountry.prefix,
                      );
                      Get.to(() => VerficationChangeMobilScreen());

                      }
                    },
                    isExpanded: true
                    )
              ],
            )),
          )
        ],
      ); 
        },
      ),
    );
  }
}