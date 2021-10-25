import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/register_company_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/sh_util.dart';

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
              // GetBuilder<SplashViewModle>(
              //   init: SplashViewModle(),
              //   initState: (_) {},
              //   builder: (val) {
              //     return DropdownButton<String>(
              //       isExpanded: true,
              //       items: val.arrCompanySector[0].sectorName.map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //       onChanged: (newValue) {},
              //     );
              //   },
              // ),
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
                  return CheckboxListTile(
                    dense: true,
                    
                    activeColor: colorPrimary,
                    checkColor: colorBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(padding0!),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Transform(
                      transform: Matrix4.translationValues(-50, 0, 0),
                      child: Text(
                          "${AppLocalizations.of(Get.context!)!.terms_and_conditions}"),
                    ),
                    value: value.isAccepte,
                    onChanged: (newValue) {
                      value.changeAcception(newValue!);
                    },
                  );
                },
              ),
              PrimaryButton(
                  isExpanded: true,
                  textButton: "${AppLocalizations.of(Get.context!)!.sign_up}",
                  onClicked: () {
                    if (_formKey.currentState!.validate()) {
                      
                    }
                  }),
              SizedBox(
                height: sizeH22,
              ),
            ],
          )),
    );
  }
}
