import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/user_model.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/register/user_register_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/widget/un_selected_button.dart';
import 'package:inbox_clients/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/terms/terms_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_company/user_company_auth_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/sh_util.dart';

import 'company_sector_item_widget.dart';

class RegisterCompanyForm extends GetWidget<AuthViewModle> {
  RegisterCompanyForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(AuthViewModle());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.tdcrNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_this_field}';
                  }
                  return null;
                },
                onSaved: (newValue){
                  controller.tdcrNumber.text = newValue!;
                  controller.update();
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText:
                        "${AppLocalizations.of(Get.context!)!.cr_number}"),
              ),
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                controller: controller.tdCompanyName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_your_company_name}';
                  }
                  return null;
                },
                onSaved: (newValue){
                  controller.tdCompanyName.text = newValue!;
                  controller.update();
                },
                decoration: InputDecoration(
                    hintText:
                        "${AppLocalizations.of(Get.context!)!.company_name}"),
              ),
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                controller: controller.tdCompanyEmail,
                onSaved: (newValue){
                  controller.tdCompanyEmail.text = newValue!;
                  controller.update();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_your_company_email}';
                  }else if(!GetUtils.isEmail(value)){
                    return '${AppLocalizations.of(Get.context!)!.please_enter_valid_email}';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText:
                        "${AppLocalizations.of(Get.context!)!.your_email_address}"),
              ),
              SizedBox(
                height: padding16,
              ),
              GetBuilder<AuthViewModle>(
                init: AuthViewModle(),
                initState: (_) {},
                builder: (logic) {
                  return TextFormField(
                      controller:
                          TextEditingController(text: logic.companySector),
                      readOnly: true,
                      onTap: () {
                        chooseSectorCompany();
                      },
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset("assets/svgs/dropdown.svg"),
                          ),
                          hintText:
                              "${AppLocalizations.of(Get.context!)!.company_sector}"));
                },
              ),
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                controller: controller.tdNameOfApplicant,
                onSaved: (newValue){
                  controller.tdNameOfApplicant.text = newValue!;
                  controller.update();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_name_of_applicant}';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText:
                        "${AppLocalizations.of(Get.context!)!.name_of_application}"),
              ),
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                controller: controller.tdApplicantDepartment,
                onSaved: (newValue){
                    controller.tdApplicantDepartment.text = newValue!;
                    controller.update();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_this_field}';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText:
                        "${AppLocalizations.of(Get.context!)!.applicant_department}"),
              ),
              SizedBox(
                height: padding16,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChooseCountryScreen());
                },
                child: Container(
                  height: sizeH60,
                  
                  decoration: BoxDecoration(
                    color: colorTextWhite,
                  ),
                  child: Row(
                    textDirection: TextDirection.ltr,
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
                          onSaved: (newValue) {
                            controller.tdMobileNumber.text =
                            newValue.toString();
                            controller.update();
                          },
                          decoration: InputDecoration(
                            counterText: "",
                          ),
                          controller: controller.tdMobileNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${AppLocalizations.of(Get.context!)!.fill_your_phone_number}';
                            }else if(value.length != 9 ){
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
              ),
              SizedBox(
                height: sizeH31,
              ),
              GetBuilder<AuthViewModle>(
                builder: (value) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          value.isAccepte = !value.isAccepte;
                          value.update();
                        },
                        child: Row(
                          children: [
                            value.isAccepte
                                ? SvgPicture.asset("assets/svgs/check.svg")
                                : SvgPicture.asset("assets/svgs/uncheck.svg"),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${AppLocalizations.of(Get.context!)!.accept_our} ",
                              style: textStyleHint()!.copyWith(fontSize: 14,fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(() => TermsScreen());
                          },
                          child: Text(
                            "${AppLocalizations.of(Get.context!)!.terms_and_conditions}",
                            style: textStyleUnderLinePrimary()!
                                .copyWith(color: colorBlack, fontSize: 14),
                          )),
                    ],
                  );
                },
              ),
              SizedBox(
                height: sizeH27,
              ),
              GetBuilder<AuthViewModle>(
                builder: (logic) {
                  return PrimaryButton(
                      isLoading: logic.isLoading,
                      isExpanded: true,
                      textButton:
                          "${AppLocalizations.of(Get.context!)!.sign_up}",
                      onClicked: () {
                        if (logic.companySector == null) {
                          snackError("${AppLocalizations.of(context)!.error_occurred}", "${AppLocalizations.of(context)!.you_have_to_choose_sector_name}");
                        }
                        if (logic.isAccepte == false) {
                          snackError("${AppLocalizations.of(context)!.error_occurred}", "${AppLocalizations.of(context)!.you_cant_register_without_accept_our_terms}");
                        }
                        if (_formKey.currentState!.validate() &&
                            logic.companySector != null && logic.isAccepte) {
                              logic.signUpCompany(
                                company: Company(
                                crNumber: logic.tdcrNumber.text,
                                countryCode: logic.defCountry.prefix,
                                companyName: logic.tdCompanyName.text,
                                companySector: logic.companySector,
                                applicantName: logic.tdNameOfApplicant.text,
                                udid: logic.identifier,
                                deviceType: logic.deviceType,
                                fcm: "${SharedPref.instance.getFCMToken()}",
                                email: logic.tdCompanyEmail.text,
                                mobile: logic.tdMobileNumber.text,
                                applicantDepartment: logic.tdApplicantDepartment.text,
                              ));
                        }
                      });
                },
              ),
              SizedBox(
                height: sizeH20,
              ),
              SharedPref.instance.getUserType().toString().toLowerCase() == "${ConstanceNetwork.bothType}" ?
              UnSelectedButton(
                textButton: "${AppLocalizations.of(Get.context!)!.register_as_user}",
                onClicked: (){
                 Get.to(() => UserRegisterScreen());
                },
              ) : const SizedBox(), 
              SizedBox(
                height: sizeH20,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => UserCompanyLoginScreen(
                        type: "${ConstanceNetwork.companyType}",
                      ));
                },
                child: RichText(
                  text: TextSpan(
                    style: textStyleTitle(),
                    children: [
                      TextSpan(
                          text:
                              "${AppLocalizations.of(Get.context!)!.have_an_account}",
                          style:
                             textStylePrimary()!.copyWith(color: colorTextHint,fontSize: 13)),
                      TextSpan(
                          text:
                              "${AppLocalizations.of(Get.context!)!.sign_in}",
                          style: textStylePrimary()!.copyWith(fontSize: 13)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: sizeH32,
              ),
              
            ],
          )),
    );
  }

  void chooseSectorCompany() {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: sizeH20!),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: sizeH40),
          Text(
            "${AppLocalizations.of(Get.context!)!.company_sector}",
            style: textStyleTitle(),
          ),
          SizedBox(height: sizeH22),
          Expanded(
            child: ListView.builder(
              itemCount: SharedPref.instance.getAppSectors()!.length,
              itemBuilder: (context, index) {
                return GetBuilder<AuthViewModle>(
                  init: AuthViewModle(),
                  builder: (logic) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {

                            logic.selectedIndex = -1;
                            logic.update();

                            logic.selectedIndex = index;
                            logic.temproreySectorName = ApiSettings.fromJson(
                                    json.decode(SharedPref.instance
                                        .getAppSetting()!
                                        .toString()))
                                .companySectors![index].name
                                .toString();
                            logic.update();
                          },
                          child: CompanySectorItem(
                              cellIndex: index,
                              selectedIndex: logic.selectedIndex,
                              sector: ApiSettings.fromJson(json.decode(
                                      SharedPref.instance
                                          .getAppSetting()!
                                          .toString()))
                                  .companySectors![index])
                        ),
                        SizedBox(
                          height: sizeH10,
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: sizeH18,
          ),
          PrimaryButton(
              isLoading: false,
              textButton: "${AppLocalizations.of(Get.context!)!.select}",
              onClicked: () {
                controller.companySector = controller.temproreySectorName;
                controller.update();
                Get.back();
              },
              isExpanded: true),
          SizedBox(
            height: sizeH34,
          ),
        ],
      ),
    ));
  }
}
