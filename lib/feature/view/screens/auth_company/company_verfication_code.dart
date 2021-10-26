import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth_company/header_code_verfication.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/register_company_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CompanyVerficationCodeScreen extends GetWidget<RegisterCompanyViewModle> {
  const CompanyVerficationCodeScreen({Key? key , required this.type}) : super(key: key);

  final String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: Column(
        children: [
          HeaderCodeVerfication(),
          Column(
            children: [
              SizedBox(
                height: sizeH16,
              ),
              Text(
                "${AppLocalizations.of(Get.context!)!.enter_your_passcode}",
                style: textStyleHints(),
              ),
              SizedBox(
                height: sizeH16,
              ),
              BildeTextActiveCode(),
             type == "user" ? SizedBox(height: sizeH38,) : const SizedBox(),
             type == "user" ? RichText(
               text: TextSpan(
                 children: [
                  TextSpan(
                    text: "${AppLocalizations.of(context)!.verify_by} ",
                    style: textStyleHint()
                    ),
                  TextSpan(
                    text: "${AppLocalizations.of(context)!.email_address}",
                    style: textStyleUnderLinePrimary()
                    
                    )
                  ]),): const SizedBox()
              ]),
              SizedBox(
                height: sizeH190,
              ),
             
              GetBuilder<RegisterCompanyViewModle>(
                init: RegisterCompanyViewModle(),
                initState: (_) {
                  controller.startTimer();
                },
                builder: (logic) {
                  return Column(
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.resend_code_in} : ${logic.startTimerCounter}",
                        style: textStyleHint(),
                        ),
                      logic.startTimerCounter == 0 ? 
                      InkWell(
                        onTap: (){
                          logic.startTimerCounter = 60;
                          logic.startTimer();
                          logic.update();
                        },
                        child: Text("${AppLocalizations.of(context)!.resend}" , style: textStyleUnderLinePrimary(),)) :
                      const SizedBox()
                    ],
                  );
                },
              )
            ],
          ),
       
    );
  }

  Widget BildeTextActiveCode() {
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
        //  errorAnimationController: errorController,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          print("Completed");
          print(v);
        },
        onChanged: (value) {
          print(value);
        },
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
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
        appContext: Get.context!,
      ),
    );
  }
}
