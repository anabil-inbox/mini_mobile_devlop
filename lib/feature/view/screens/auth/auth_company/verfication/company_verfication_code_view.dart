import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widget/header_code_verfication_widget.dart';

class CompanyVerficationCodeScreen extends StatefulWidget {
   CompanyVerficationCodeScreen(
      {Key? key,
      required this.id,
      required this.type,
      required this.countryCode,
      required this.mobileNumber})
      : super(key: key);
  final String id;
  final String type;
  final String mobileNumber;
  final String countryCode;
  

  @override
  State<CompanyVerficationCodeScreen> createState() => _CompanyVerficationCodeScreenState();
}

class _CompanyVerficationCodeScreenState extends State<CompanyVerficationCodeScreen> {

  
  final AuthViewModle authViewModle = Get.find<AuthViewModle>();
  
  @override
  void initState() {
    Get.lazyPut(() => AuthViewModle());
    super.initState();
    authViewModle.startTimerCounter = 60;
    authViewModle.startTimer();
    Future.delayed(Duration(seconds: 2)).then((value) => {
      authViewModle.tdPinCode.text = "1234",
    
    });
  }


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
            bildeTextActiveCode(context,authViewModle.tdPinCode),
            widget.type == ConstanceNetwork.userType
                ? SizedBox(
                    height: sizeH38,
                  )
                : const SizedBox(),
            widget.type == ConstanceNetwork.userType
                ? InkWell(
                    splashColor: colorTrans,
                    highlightColor: colorTrans,
                    onTap: (){
                    if(authViewModle.startTimerCounter == 0) {
                        authViewModle.startTimerCounter = 60;
                        authViewModle.startTimer();
                        authViewModle.update();
                        authViewModle.reSendVerficationCode(
                        udid: authViewModle.identifier,
                        // countryCode: countryCode,
                        // mobileNumber: mobileNumber,
                        target: "email"
                        );
                    }  else {
                        print("msg_Blocked ${authViewModle.startTimerCounter}");
                    }                   
                  } ,
                  child: RichText(
                      text: TextSpan(
                         style: textStyleTitle(),
                        children: [
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
          authViewModle.isLoading ? ThreeSizeDot() : GetBuilder<AuthViewModle>(
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
                              value.reSendVerficationCode(
                              id: widget.id, 
                              countryCode: widget.countryCode,
                              target: ConstanceNetwork.userType == "${widget.type}" ? "sms" : "eamil",
                              mobileNumber: widget.mobileNumber,
                              udid: value.identifier,
                            );
                           
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
    TextEditingController controller
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW80!),
      child: PinCodeTextField(
        controller: controller,
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

          authViewModle.checkVerficationCode(
            countryCode: "",
            id: widget.id,
            mobileNumber: "",
            code: v.toString(),
          
          );
        
        },
        onChanged: (value) {
        //   if(value.isEmpty) {
        //   //  return kPleaseActiveCode.tr;
        //   }else if(value.length!=4) {
        //  //   return kPleaseActiveCode.tr;
        //   }else{
        //     print("msg_in_else");
        //     authViewModle.checkVerficationCode(
        //     countryCode: "",
        //     id: widget.id,
        //     mobileNumber: "",
        //     code: value.toString(),
        //   );
        //   }
        },
        // validator: (value) {
        //   if(value.isEmpty) {
        //     return kPleaseActiveCode.tr;
        //   }else if(value.length!=4) {
        //    // return kPleaseActiveCode.tr;
        //   }else{
        //     return null;
        //   }
        // },
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
