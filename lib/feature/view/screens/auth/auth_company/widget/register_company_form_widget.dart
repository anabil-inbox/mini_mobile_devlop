import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/user_model.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/register/user_register_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/terms/terms_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/company_both_login/company_both_login_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:inbox_clients/util/sh_util.dart';

import 'company_sector_item_widget.dart';

class RegisterCompanyForm extends GetWidget<AuthViewModle> {
  RegisterCompanyForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    Get.put(AuthViewModle());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                                textCapitalization: TextCapitalization.sentences,

                controller: controller.tdcrNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${tr.fill_cr_number}';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  controller.tdcrNumber.text = newValue!;
                  controller.update();
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText:
                        "${tr.cr_number}"),
              ),
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: controller.tdCompanyName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${tr.fill_your_company_name}';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  controller.tdCompanyName.text = newValue!;
                  controller.update();
                },
                decoration: InputDecoration(
                    hintText:
                        "${tr.company_name}"),
              ),
           
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                controller: controller.tdCompanyEmail,
                onSaved: (newValue) {
                  controller.tdCompanyEmail.text = newValue!;
                  controller.update();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${tr.fill_your_company_email}';
                  } else if (!GetUtils.isEmail(value)) {
                    return '${tr.please_enter_valid_email}';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText:
                        "${tr.your_email_address}"),
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
                          TextEditingController(text: GetUtils.isNull(logic.companySector?.sectorName) ? "" : 
                          logic.companySector!.sectorName),
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
                              "${tr.company_sector}"));
                },
              ),
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: controller.tdNameOfApplicant,
                onSaved: (newValue) {
                  controller.tdNameOfApplicant.text = newValue!;
                  controller.update();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${tr.fill_name_of_applicant}';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText:
                        "${tr.name_of_application}"),
              ),
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                controller: controller.tdApplicantDepartment,
                onSaved: (newValue) {
                  controller.tdApplicantDepartment.text = newValue!;
                  controller.update();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${tr.fill_the_applicant_department}';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText:
                        "${tr.applicant_department}"),
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
                  child: GetBuilder<AuthViewModle>(
                    init: AuthViewModle(),
                    initState: (_) {},
                    builder: (_) {
                      return Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          SizedBox(
                            width: sizeW18,
                          ),
                          controller.defCountry.name!
                                      .toLowerCase()
                                      .contains("qatar") ||
                                  controller.defCountry.name!.isEmpty
                              ? SvgPicture.asset("assets/svgs/qatar_flag.svg")
                              : imageNetwork(
                                  url:
                                      "${ConstanceNetwork.imageUrl}${controller.defCountry.flag}",
                                  width: 36,
                                  height: 26),
                                       SizedBox(
                            width: sizeW5,
                          ),
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
                              maxLength: 10,
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
                               return phoneVaild(value.toString());
                              },
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      );
                   
                    },
                  ),
                ),
              ),SizedBox(
                height: padding16,
              ),
              TextFormField(
                controller: controller.tdCompanyEmailOperator,
                onSaved: (newValue) {
                  controller.tdCompanyEmailOperator.text = newValue!;
                  controller.update();
                },
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return '${tr.fill_your_company_email}';
                //   } else if (!GetUtils.isEmail(value)) {
                //     return '${tr.please_enter_valid_email}';
                //   }
                //   return null;
                // },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText:
                    "${tr.your_email_address_operator}"),
              ),
              SizedBox(
                height: padding16,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChooseCountryScreen(isOperator:true));
                },
                child: Container(
                  height: sizeH60,
                  decoration: BoxDecoration(
                    color: colorTextWhite,
                  ),
                  child: GetBuilder<AuthViewModle>(
                    init: AuthViewModle(),
                    initState: (_) {},
                    builder: (_) {
                      return Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          SizedBox(
                            width: sizeW18,
                          ),
                          controller.defCountryOperator.name!
                              .toLowerCase()
                              .contains("qatar") ||
                              controller.defCountryOperator.name!.isEmpty
                              ? SvgPicture.asset("assets/svgs/qatar_flag.svg")
                              : imageNetwork(
                              url:
                              "${ConstanceNetwork.imageUrl}${controller.defCountryOperator.flag}",
                              width: 36,
                              height: 26),
                          SizedBox(
                            width: sizeW5,
                          ),
                          VerticalDivider(),
                          GetBuilder<AuthViewModle>(
                            init: AuthViewModle(),
                            initState: (_) {},
                            builder: (value) {
                              return Text(
                                "${value.defCountryOperator.prefix == null || value.defCountryOperator.prefix!.isEmpty ? "+974" : value.defCountryOperator.prefix}",
                                textDirection: TextDirection.ltr,
                              );
                            },
                          ),
                          Expanded(
                            child: TextFormField(
                              textDirection: TextDirection.ltr,
                              maxLength: 10,
                              onSaved: (newValue) {
                                if(newValue.toString().isNotEmpty){
                                  var phonev= phoneVaild(newValue.toString());
                                  if(phonev != null){
                                    snackError("", phonev.toString());
                                  }
                                }
                                controller.tdMobileNumberOperator.text =
                                    newValue.toString();
                                controller.update();
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                hintText: tr.mobile_operator
                              ),
                              controller: controller.tdMobileNumberOperator,
                              // validator: (value) {
                              //   if(value.toString().isNotEmpty) {
                              //     return phoneVaild(value.toString());
                              //   }else{
                              //     return "";
                              //   }
                              // },
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      );

                    },
                  ),
                ),
              )
              ,SizedBox(
                height: padding16,
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
                                ? SvgPicture.asset("assets/svgs/check.svg",color: colorPrimary,)
                                : SvgPicture.asset("assets/svgs/uncheck.svg",color: colorPrimary,),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${tr.accept_our} ",
                              style: textStyleHint()!.copyWith(
                                  fontSize: fontSize14, fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(() => TermsScreen());
                          },
                          child: Text(
                            "${tr.terms_and_conditions}",
                            style: textStyleUnderLinePrimary()!
                                .copyWith(color: colorBlack, fontSize: fontSize14),
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
                          "${tr.sign_up}",
                      onClicked: () {
                        if (logic.companySector == null) {
                          snackError(
                              "${tr.error_occurred}",
                              "${tr.you_have_to_choose_sector_name}");
                        }
                        if (logic.isAccepte == false) {
                          snackError(
                              "${tr.error_occurred}",
                              "${tr.you_cant_register_without_accept_our_terms}");
                        }
                        if (_formKey.currentState!.validate() &&
                            logic.companySector != null &&
                            logic.isAccepte) {
                          logic.signUpCompany(
                              company: Company(
                            crNumber: logic.tdcrNumber.text,
                            reporterMobile: logic.tdCompanyEmailOperator.text,
                            reporterEmail: logic.tdMobileNumberOperator.text,
                            countryCode:
                                logic.defCountry.prefix,
                            companyName: logic.tdCompanyName.text,
                            companySector: logic.companySector!.name,
                            applicantName: logic.tdNameOfApplicant.text,
                            udid: logic.identifier,
                            deviceType: logic.deviceType,
                            fcm: "${SharedPref.instance.getFCMToken()}",
                            email: logic.tdCompanyEmail.text,
                            mobile: logic.tdMobileNumber.text,
                            applicantDepartment:
                                logic.tdApplicantDepartment.text,
                          ));
                        }
                      });
                },
              ),
              SizedBox(
                height: sizeH20,
              ),
              SharedPref.instance.getUserType().toString().toLowerCase() ==
                      "${ConstanceNetwork.bothType}"
                  ? SeconderyFormButton(
                buttonText:
                          "${tr.register_as_user}",
                      onClicked: () {
                        Get.to(() => UserRegisterScreen());
                      },
                    )
                  : const SizedBox(),
              SizedBox(
                height: sizeH20,
              ),
              InkWell(
                onTap: () {
                  Get.offAll(() => CompanyBothLoginScreen());
                },
                child: RichText(
                  text: TextSpan(
                    style: textStyleTitle(),
                    children: [
                      TextSpan(
                          text:
                              "${tr.have_an_account}",
                          style: textStylePrimary()!
                              .copyWith(color: colorTextHint, fontSize: 13)),
                      TextSpan(
                          text: "${tr.sign_in}",
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
    Get.bottomSheet(
      Container(
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: sizeH20!),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: sizeH40),
          Text(
            "${tr.company_sector}",
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
                                  .companySectors![index];
                              logic.update();
                            },
                            child: CompanySectorItem(
                                cellIndex: index,
                                selectedIndex: logic.selectedIndex,
                                sector: ApiSettings.fromJson(json.decode(
                                        SharedPref.instance
                                            .getAppSetting()!
                                            .toString()))
                                    .companySectors![index])),
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
              textButton: "${tr.select}",
              onClicked: () {
                print("${controller.companySector}");
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
