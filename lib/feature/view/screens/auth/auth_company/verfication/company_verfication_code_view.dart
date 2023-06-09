// import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'dart:io';

import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:smart_auth/smart_auth.dart';
// import 'package:sms_autofill/sms_autofill.dart';

import '../widget/header_code_verfication_widget.dart';

class CompanyVerficationCodeScreen extends StatefulWidget {
  CompanyVerficationCodeScreen({Key? key,
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
  State<CompanyVerficationCodeScreen> createState() =>
      _CompanyVerficationCodeScreenState();
}

class _CompanyVerficationCodeScreenState
    extends State<CompanyVerficationCodeScreen> {

  final AuthViewModle authViewModle = Get.put<AuthViewModle>(AuthViewModle());
  // final smartAuth = SmartAuth();
  @override
  void initState() {
    // Get.lazyPut(() => AuthViewModle());
    super.initState();
    initListener();

    // Future.delayed(Duration(seconds: 2)).then((value) => {
    //   authViewModle.tdPinCode.text = "1234",
    // });


  }

  // void getAppSignature() async {
  //   final res = await smartAuth.getAppSignature();
  //   debugPrint('Signature: $res');
  // }
  // void getSmsCode() async {
  //   final res = await smartAuth.getSmsCode();
  //   debugPrint('SMS: ${res.code}');
  //   if (res.succeed) {
  //     debugPrint('SMS: ${res.code}');
  //     if(res.code != null && res.code!.length > 33) {
  //       authViewModle.tdPinCode.text = res.code!.substring(33);
  //       authViewModle.update();
  //     }
  //   } else {
  //     debugPrint('SMS Failure:');
  //   }
  // }

  initListener() async {
    authViewModle.startTimerCounter = 59;
    authViewModle.startTimer();
    if(Platform.isAndroid) {
      String? appSignature = await AndroidSmsRetriever.getAppSignature();
      Logger().w(appSignature);
      // getAppSignature();
      // getSmsCode();
      String? message = await AndroidSmsRetriever.listenForSms();
      Logger().w(message);
      if (message != null && message.length > 33) {
        authViewModle.tdPinCode.text = message.substring(33);
        authViewModle.update();
      }
    }
    initSmsListener();

  }

  // String _commingSms = 'Unknown';

  Future<void> initSmsListener() async {
    String? commingSms;
    try {
      // commingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      commingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;

    // setState(() {
    //   _commingSms = commingSms!;
    // });
    Logger().d("sms_$commingSms");
    if(commingSms != null && commingSms.length > 33) {
      authViewModle.tdPinCode.text = commingSms.substring(33);
      authViewModle.update();
    }
  }

  // @override
  // void codeUpdated() {
  //   authViewModle.tdPinCode.text = code!;
  //   authViewModle.update();
  //   Logger().d("codeUpdated_${code!}");
  // }

  @override
  void dispose() {
    // SmsAutoFill().unregisterListener();
    // AltSmsAutofill().unregisterListener();
    // smartAuth.removeSmsListener();
    AndroidSmsRetriever.stopSmsListener();
    super.dispose();
    // cancel();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: GetBuilder<AuthViewModle>(
        assignId: true,
        builder: (logic) {
          return ListView(
            padding: const EdgeInsets.all(0),
            children: [
              HeaderCodeVerfication(),
              Column(children:
              [
                SizedBox(
                  height: sizeH16,
                ),
                Text(
                  "${tr.enter_your_passcode}",
                  style: textStyleHints(),
                ),
                SizedBox(
                  height: sizeH16,
                ),

                GetBuilder<AuthViewModle>(builder: (logic) {
                  return bildeTextActiveCode(context,
                      authViewModle.tdPinCode
                  );
                }),
                widget.type == ConstanceNetwork.userType
                    ? SizedBox(
                  height: sizeH38,
                )
                    : const SizedBox(),
                widget.type == ConstanceNetwork.userType
                    ? InkWell(
                  splashColor: colorTrans,
                  highlightColor: colorTrans,
                  onTap: () async{
                    // if (authViewModle.startTimerCounter == 0) {

                      await authViewModle.reSendVerficationCode(
                          id: widget.id,
                          udid: authViewModle.identifier,
                           // countryCode: widget.countryCode,
                           // mobileNumber: widget.mobileNumber,
                          target: ConstanceNetwork.emailKey
                      );
                      authViewModle.startTimerCounter = 59;
                      authViewModle.startTimer();
                      authViewModle.update();
                    // } else {
                    //   print("msg_Blocked ${authViewModle.startTimerCounter}");
                    // }
                  },
                  child: RichText(
                    text: TextSpan(
                        style: textStyleTitle(),
                        children: [
                          TextSpan(
                              text: "${tr.verify_by} ",
                              style: textStyleHint()!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: fontSize14
                              )),
                          TextSpan(
                              text:
                              "${tr.email_address}",
                              style: textStyleUnderLinePrimary()!.copyWith(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: fontSize14
                              ))
                        ]),
                  ),
                )
                    : const SizedBox()
              ]
              ),
              SizedBox(
                height: sizeH190,
              ),
              authViewModle.isLoading ? ThreeSizeDot(color_1: colorPrimary,color_2: colorPrimary,color_3: colorPrimary,) : GetBuilder<
                  AuthViewModle>(
                builder: (value) {
                  return Column(
                    children: [
                      value.startTimerCounter != 0 ? Text(
                        "${tr.resend_code_in}  00 : ${value.startTimerCounter}",
                        style: textStyleHint()!.copyWith(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            fontSize: fontSize14),
                      ) : const SizedBox(),
                      value.startTimerCounter == 0
                          ? InkWell(
                          splashColor: colorTrans,
                          highlightColor: colorTrans,
                          onTap: () {
                            value.reSendVerficationCode(
                              id: widget.id,
                              countryCode: widget.countryCode,
                              target: ConstanceNetwork.userType ==
                                  "${widget.type}"
                                  ? ConstanceNetwork.smsKey//"sms"
                                  : ConstanceNetwork.emailKey,//"email"
                              mobileNumber: widget.mobileNumber,
                              udid: value.identifier,
                            );
                          },
                          child: Text(
                            "${tr.resend}",
                            style: textStyleUnderLinePrimary()!.copyWith(
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                fontSize: fontSize14),
                          ))
                          : const SizedBox()
                    ],
                  );
                },
              )

            ],
          );
        },
      ),
    );
  }

  Widget bildeTextActiveCode(BuildContext context,
      TextEditingController controller) {
    //region Description
    try {
      return GetBuilder<AuthViewModle>(builder: (logic) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeW80!),
          child: AutofillGroup(
            child: PinCodeTextField(
              autoFocus: true,
              controller: controller,
              enablePinAutofill: true,
              keyboardType: TextInputType.numberWithOptions(),
              // useExternalAutoFillGroup: true,
              // onAutoFillDisposeAction: true,
              // useExternalAutoFillGroup: true,
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
                  activeColor: colorTextWhite,
                  selectedColor: colorTextWhite,
                  borderRadius: BorderRadius.circular(sizeRadius10!)

              ),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: colorScaffoldRegistrationBody,
              enableActiveFill: true,
              // keyboardType: TextInputType.,
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
          ),
        );
      });
    } catch (e) {
      print(e);
      Logger().d(e);
      return const SizedBox.shrink();
    }
    //endregion
  }


}
