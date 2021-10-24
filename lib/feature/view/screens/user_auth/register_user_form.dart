import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/user_auth/terms_screen.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/app_style.dart';

class RegisterUserForm extends GetWidget<AuthViewModle> {
  RegisterUserForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                color: colorTextWhite,
                height: sizeH60,
                child: GetBuilder<AuthViewModle>(
                  init: AuthViewModle(),
                  builder: (_) {
                    return DropdownButton(
                      isExpanded: true,
                      itemHeight: sizeH60,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      onChanged: (e) {
                        controller.onChangeDropDownList(e.toString());
                      },
                      value: controller.dropDown,
                      items: controller.countres
                          .map(
                            (map) => DropdownMenuItem(
                                child: Text(map.name!), value: map.name),
                          )
                          .toList(),
                    );
                  },
                ),
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
                        "${AppLocalizations.of(Get.context!)!.full_name}"),
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
              PrimaryButton(
                  isExpanded: true,
                  textButton: "${AppLocalizations.of(Get.context!)!.sign_up}",
                  onClicked: () {
                    if (_formKey.currentState!.validate()) {}
                  }),
              SizedBox(
                height: sizeH22,
              ),
              GetBuilder<AuthViewModle>(
                builder: (value) {
                  return CheckboxListTile(
                    activeColor: colorPrimary,
                    checkColor: colorBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(padding0!),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            style: textStyleIntroBody(),
                            text:
                                "${AppLocalizations.of(Get.context!)!.accept_our} "),
                        TextSpan(
                          
                          style: textStyleUnderLinePrimary(),
                          text:
                              "${AppLocalizations.of(Get.context!)!.terms_and_conditions}",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                              Get.to(() => TermsScreen())},
                        ),
                      ]),
                    ),
                    value: value.isAccepte,
                    onChanged: (newValue) {
                      value.changeAcception(newValue!);
                    },
                  );
                },
              ),
              SizedBox(
                height: sizeH120,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text:
                            "${AppLocalizations.of(Get.context!)!.dont_have_an_account}",
                        style: textStylePrimary()!.copyWith(color: colorBlack)),
                    TextSpan(
                        text:
                            "${AppLocalizations.of(Get.context!)!.sign_up_here}",
                        style: textStylePrimary()),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
