import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/user_modle.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth/terms/terms_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
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

import '../../country/choose_country_view.dart';

class RegisterUserForm extends GetWidget<AuthViewModle> {
  RegisterUserForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
                child: GetBuilder<AuthViewModle>(
                  init: AuthViewModle(),
                  initState: (_) {},
                  dispose: (_) {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      _.controller?.clearAllControllers();
                    });
                  },
                  builder: (_) {
                    return Container(
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
                                  "${value.defCountry.prefix == null ? "+974" : value.defCountry.prefix}");
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
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: padding16,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                onSaved: (newValue) {
                  controller.tdName.text = newValue.toString();
                  controller.update();
                },
                controller: controller.tdName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${tr.fill_your_name}';
                  } else if (value.length <= 2) {}
                  return null;
                },
                decoration: InputDecoration(hintText: "${tr.full_name}"),
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
                    return '${tr.fill_your_email}';
                  } else if (!GetUtils.isEmail(value)) {
                    return "${tr.please_enter_valid_email}";
                  }
                  emailValid(value);
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration:
                    InputDecoration(hintText: "${tr.your_email_address}"),
              ),
              SizedBox(
                height: padding32,
              ),
              GetBuilder<AuthViewModle>(
                builder: (value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                : SvgPicture.asset(
                                    "assets/svgs/uncheck.svg",
                                    color: seconderyColor,
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomTextView(
                              txt: "${tr.accept_our} ",
                              textStyle: textStyle(),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(() => TermsScreen());
                          },
                          child: CustomTextView(
                            txt: "${tr.terms_and_conditions}",
                            textAlign: TextAlign.start,
                            textStyle: textStyleUnderLinePrimary()!.copyWith(
                                color: colorBlack, fontSize: fontSize14),
                          )),
                    ],
                  );
                },
              ),
              SizedBox(
                height: padding32,
              ),
              GetBuilder<AuthViewModle>(
                builder: (_) {
                  return PrimaryButton(
                      isLoading: controller.isLoading,
                      isExpanded: true,
                      textButton: "${tr.sign_up}",
                      onClicked: () {
                        if (!controller.isAccepte) {
                          snackError("${tr.error_occurred}",
                              "${tr.you_cant_register_without_accept_our_terms}");
                        }

                        if (_formKey.currentState!.validate() &&
                            controller.isAccepte) {
                          controller.signUpUser(
                              user: User(
                                  deviceType: controller.deviceType,
                                  mobile: controller.tdMobileNumber.text,
                                  email: controller.tdEmail.text,
                                  fullName: controller.tdName.text,
                                  udid: controller.identifier,
                                  fcm: "${SharedPref.instance.getFCMToken()}",
                                  countryCode:
                                      "${controller.defCountry.prefix}"));
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
                      buttonText: "${tr.register_as_company}",
                      onClicked: () {
                        Get.to(() => RegisterCompanyScreen());
                      },
                    )
                  : const SizedBox(),
              SizedBox(height: sizeH80),
              InkWell(
                onTap: () {
                  Get.to(() => UserBothLoginScreen());
                },
                child: RichText(
                  text: TextSpan(
                    style: textStyleTitle(),
                    children: [
                      TextSpan(
                          text: "${tr.have_an_account}",
                          style: textStylePrimary()!
                              .copyWith(color: colorBlack, fontSize: 13)),
                      TextSpan(
                          text: "${tr.sign_in}",
                          style: textStylePrimary()!.copyWith(fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
