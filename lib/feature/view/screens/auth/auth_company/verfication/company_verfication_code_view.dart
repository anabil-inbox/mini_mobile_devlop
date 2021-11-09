import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widget/header_code_verfication_widget.dart';

class CompanyVerficationCodeScreen extends GetWidget<AuthViewModle> {
  const CompanyVerficationCodeScreen(
      {Key? key,
      required this.type,
      required this.countryCode,
      required this.mobileNumber})
      : super(key: key);

  final String type;
  final String mobileNumber;
  final String countryCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          HeaderCodeVerfication(),
          Column(children: [
            SizedBox(
              height: sizeH16,
            ),
            Text(
              "${AppLocalizations.of(context)!.enter_your_passcode}",
              style: textStyleHints(),
            ),
            SizedBox(
              height: sizeH16,
            ),
            bildeTextActiveCode(context),
            type == ConstanceNetwork.userType
                ? SizedBox(
                    height: sizeH38,
                  )
                : const SizedBox(),
            type == ConstanceNetwork.userType
                ? InkWell(
                    splashColor: colorTrans,
                    highlightColor: colorTrans,
                    onTap: (){
                    if(controller.startTimerCounter == 0) {
                        print("msg_controller_timer ${controller.startTimerCounter}");
                        controller.startTimerCounter = 60;
                        controller.startTimer();
                        controller.update();
                        // controller.reSendVerficationCode(
                        // udid: controller.identifier,
                        // countryCode: countryCode,
                        // mobileNumber: mobileNumber,
                        // target: "email"
                        // );
                    }  else {
                        print("msg_Blocked ${controller.startTimerCounter}");
                    }                   
                  } ,
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "${AppLocalizations.of(context)!.verify_by} ",
                            style: textStyleHint()!.copyWith(
                              fontWeight: FontWeight.normal,fontSize: fontSize14
                            )),
                        TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.email_address}",
                            style: textStyleUnderLinePrimary()!.copyWith(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,fontSize: fontSize14
                            ))
                      ]),
                    ),
                )
                : const SizedBox()
          ]),
          SizedBox(
            height: sizeH190,
          ),
          GetBuilder<AuthViewModle>(
            init: AuthViewModle(),
            initState: (_) {
              controller.startTimer();
            },
            builder: (value) {
              return Column(
                children: [
                 value.startTimerCounter != 0 ? Text(
                    "${AppLocalizations.of(context)!.resend_code_in} : ${value.startTimerCounter}",
                    style: textStyleHint()!.copyWith(decoration: TextDecoration.none,fontWeight: FontWeight.normal,fontSize: fontSize14),
                  ) : const SizedBox(),
                  value.startTimerCounter == 0
                      ? InkWell(
                          splashColor: colorTrans,
                          highlightColor: colorTrans,
                          onTap: () {
                            //   value.reSendVerficationCode(
                            //   countryCode: countryCode,
                            //   target: type == "user" ? "sms" : "eamil",
                            //   mobileNumber: mobileNumber,
                            //   udid: value.identifier,
                            // );
                            value.startTimerCounter = 60;
                            value.startTimer();
                            value.update();
                          },
                          child: Text(
                            "${AppLocalizations.of(context)!.resend}",
                            style: textStyleUnderLinePrimary()!.copyWith(decoration: TextDecoration.none,fontWeight: FontWeight.normal,fontSize: fontSize14),
                          ))
                      : const SizedBox()
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget bildeTextActiveCode(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW80!),
      child: PinCodeTextField(
        hintCharacter: "__",
        hintStyle: textStyleTitle(),
        length: 4,
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          fieldHeight: 50,
          fieldWidth: 50,
          disabledColor: Color(0xFFCECECE),
          selectedFillColor: colorTextWhite,
          activeFillColor: colorTextWhite,
          inactiveFillColor: colorTextWhite,
          inactiveColor: Color(0xFFCECECE),
        ),
        cursorColor: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: colorScaffoldRegistrationBody,
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          controller.checkVerficationCode(
            countryCode: countryCode,
            mobileNumber: mobileNumber,
            code: v.toString(),
            udid: controller.identifier,
          );
        },
        onChanged: (value) {},
        /*validator: (value) {
          if(value.isEmpty) {
            return kPleaseActiveCode.tr;
          }else if(value.length!=4) {
           // return kPleaseActiveCode.tr;
          }else{
            return null;
          }
        },*/
        beforeTextPaste: (text) {
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
        appContext: context,
      ),
    );
  }
}
