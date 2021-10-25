import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/user_auth/choose_country_screen.dart';
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
                          onSaved: (newValue) {
                            controller.tdMobileNumber.text =
                                newValue.toString();
                            controller.update();
                          },
                          controller: controller.tdMobileNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${AppLocalizations.of(Get.context!)!.fill_this_field}';
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
                height: padding16,
              ),
              TextFormField(
                onSaved: (newValue) {
                  controller.tdName.text = newValue.toString();
                  controller.update();
                },
                controller: controller.tdName,
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
                onSaved: (newValue) {
                  controller.tdEmail.text = newValue.toString();
                },
                controller: controller.tdEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(Get.context!)!.fill_this_field}';
                  }else if(!(value.contains("@") && value.length > 10 )){
                    return "${AppLocalizations.of(Get.context!)!.please_enter_valid_email}";
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
                  onClicked: () async {
                    if (_formKey.currentState!.validate()) {
                      controller.signUpUser(
                          user: User(
                              deviceType: controller.deviceType,
                              mobile: controller.tdMobileNumber.text,
                              email: controller.tdEmail.text,
                              fullName: controller.tdName.text,
                              udid: controller.identifier,
                              fcm: "fcm1",
                              countryCode: "972"
                              )
                        );
                    }
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
                            ..onTap = () => {Get.to(() => TermsScreen())},
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
              SizedBox(
                height: sizeH70,
              ),
            ],
          )),
    );
  }
}
