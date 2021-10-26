import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth_user/terms_screen.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/register_company_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/sh_util.dart';

import '../company_sector_item.dart';

class RegisterCompanyForm extends GetWidget<RegisterCompanyViewModle> {
  RegisterCompanyForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("${SharedPref.instance.getAppSetting()}");

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_this_field}';
                  }
                  return null;
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_this_field}';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText:
                        "${AppLocalizations.of(Get.context!)!.company_name}"),
              ),
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_this_field}';
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
              GetBuilder<RegisterCompanyViewModle>(
                init: RegisterCompanyViewModle(),
                initState: (_) {},
                builder: (_) {
                  return TextFormField(
                      controller:
                          TextEditingController(text: controller.companySector),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_this_field}';
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
              GetBuilder<RegisterCompanyViewModle>(
                builder: (value) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: (){
                          value.isAccepte = !value.isAccepte;
                          value.update();
                        },
                        child: Row(
                          children: [
                           value.isAccepte ? SvgPicture.asset("assets/svgs/uncheck.svg") :
                           SvgPicture.asset("assets/svgs/check.svg"),
                           SizedBox(width: 10,),
                           Text("${AppLocalizations.of(Get.context!)!.accept_our} ",) 
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(TermsScreen());
                        },
                        child: Text("${AppLocalizations.of(Get.context!)!.terms_and_conditions}" , 
                        style: textStyleUnderLinePrimary()!.copyWith(color: colorBlack),)),
                    ],
                  );
                },
              ),
              SizedBox(height: sizeH20,),
              PrimaryButton(
                  isExpanded: true,
                  textButton: "${AppLocalizations.of(Get.context!)!.sign_up}",
                  onClicked: () {
                    if (_formKey.currentState!.validate()) {}
                  }),
              SizedBox(
                height: sizeH38,
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
                return GetBuilder<RegisterCompanyViewModle>(
                  init: RegisterCompanyViewModle(),
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
                                .companySectors![index]
                                .sectorName!
                                .toString();
                            logic.update();
                          },
                          child: CompanySectorItem(
                              cellIndex: index,
                              selectedIndex: logic.selectedIndex,
                              sectorText: ApiSettings.fromJson(json.decode(
                                      SharedPref.instance
                                          .getAppSetting()!
                                          .toString()))
                                  .companySectors![index]
                                  .sectorName!
                                  .toString()),
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
              textButton: "${AppLocalizations.of(Get.context!)!.select}",
              onClicked: () {
                controller.companySector = controller.temproreySectorName;
                controller.update();
                Get.back();
                print("msg_sector_name ${controller.companySector}");
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
