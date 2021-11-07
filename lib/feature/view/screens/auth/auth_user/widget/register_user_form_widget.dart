import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth/terms/terms_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_company/user_company_auth_view.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../../country/choose_country_view.dart';

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
                              return '${AppLocalizations.of(Get.context!)!.fill_this_field}';
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
                  } else if (!(value.contains("@") && value.length > 10)) {
                    return "";
                  }
                  // you have to use email validation from getX. 
                  // you have an getx , methods for this validation.
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
                builder: (value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          value.isAccepte = !value.isAccepte;
                          value.update();
                        },
                        child: Row(

                          children: [
                            value.isAccepte ? SvgPicture.asset("assets/svgs/check.svg") :
                            SvgPicture.asset("assets/svgs/uncheck.svg"),
                            SizedBox(width: 10,),
                            CustomTextView(txt:"${AppLocalizations.of(Get.context!)!.accept_our} ",textStyle: textStyle(),)
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: (){
                            Get.to(() => TermsScreen());
                          },
                          child: CustomTextView(txt:"${AppLocalizations.of(Get.context!)!.terms_and_conditions}" ,
                            textAlign:TextAlign.start,
                            textStyle: textStyleUnderLinePrimary()!.copyWith(color: colorBlack , fontSize: fontSize14),)),
                    ],
                  );
                },
              ),
              SizedBox(
                height: sizeH22,
              ),
              GetBuilder<AuthViewModle>(
                builder: (_) {
                  return PrimaryButton(
                      isLoading: controller.isLoading,
                      isExpanded: true,
                      textButton:
                      "${AppLocalizations.of(Get.context!)!.sign_up}",
                      onClicked: () {
                        if(!controller.isAccepte){
                          snackError("${AppLocalizations.of(Get.context!)!.error_occurred}",
                              "${AppLocalizations.of(Get.context!)!.you_cant_register_without_accept_our_terms}");
                        }

                        if (_formKey.currentState!.validate() && controller.isAccepte) {
                          controller.signUpUser(
                              user: User(
                                  deviceType: controller.deviceType,
                                  mobile: controller.tdMobileNumber.text,
                                  email: controller.tdEmail.text,
                                  fullName: controller.tdName.text,
                                  udid: controller.identifier,
                                  fcm: "fcm1",
                                  countryCode: "972"));
                        }

                      });
                },
              ),
              SizedBox(
                height: sizeH120,
              ),
              InkWell(
                onTap: (){
                  
                  Get.to(() => UserCompanyLoginScreen(type: "${ConstanceNetwork.userType}",));
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text:
                              "${AppLocalizations.of(Get.context!)!.have_an_account}",
                          style: textStylePrimary()!.copyWith(color: colorBlack)),
                      TextSpan(
                          text:
                              "${AppLocalizations.of(Get.context!)!.sign_up_here}",
                          style: textStylePrimary()),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: sizeH48,
              ),

            ],
          )),
    );
  }
}
