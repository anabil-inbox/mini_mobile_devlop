import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/widget/header_code_verfication_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'package:inbox_clients/util/font_dimne.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class VerficationChangeMobilScreen extends StatefulWidget {

  @override
  State<VerficationChangeMobilScreen> createState() => _ChangeMobilScreenState();
}

class _ChangeMobilScreenState extends State<VerficationChangeMobilScreen> {

  ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();
  @override
  void initState() {
    super.initState();
    profileViewModle.startTimerCounter = 60;
    profileViewModle.startTimer();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          HeaderCodeVerfication(),
          Column(
            children: [
            SizedBox(
              height: sizeH16,
            ),
            Text(
              "${tr.enter_your_passcode}",
              style: textStyleHints(),
            ),     
            SizedBox(
                height: sizeH30!,
              ),
            bildeTextActiveCode(context),  
            SizedBox(
            height: sizeH190,
          ),
            GetBuilder<ProfileViewModle>(
            builder: (value) {
              return Column(
                children: [
                 value.startTimerCounter != 0 ? Text(
                    "${tr.resend_code_in} : ${value.startTimerCounter}",
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
                            "${tr.resend}",
                            style: textStyleUnderLinePrimary()!.copyWith(decoration: TextDecoration.none,fontWeight: FontWeight.normal,fontSize: fontSize14),
                          ))
                      : const SizedBox()
                ],
              );
            },
          )
        ],
      ),
         ]));
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
          if(v=="1234"){
            Get.put(ProfileViewModle());
            Get.offAll(() => HomePageHolder());
          }
          // authViewModle.checkVerficationCode(
          //   countryCode: countryCode,
          //   mobileNumber: mobileNumber,
          //   code: v.toString(),
          //   udid: controller.identifier,
          // );
        
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
