import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/sh_util.dart';

import '../../../../../../../util/app_color.dart';
import '../../../../../../../util/app_dimen.dart';
import '../../../../../../../util/app_shaerd_data.dart';
import '../../../../../../../util/app_style.dart';
import '../../../../../../../util/constance.dart';
import '../../../../../../../util/string.dart';
import '../../../../../widgets/custom_text_filed.dart';
import '../../../../../widgets/custome_text_view.dart';
import '../../../../../widgets/primary_button.dart';
import 'help_center_widget/social_share_buttons.dart';

class HelpCenterScreen extends StatelessWidget {
  final bool? helpCenter;

  const HelpCenterScreen({
    Key? key,
    this.helpCenter = false,
  }) : super(key: key);


  static var _emailController = TextEditingController();
  static var _noteController = TextEditingController();
  static GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorScaffoldRegistrationBody,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 1,
          title: Text(
            helpCenter! ? tr.txtHelpCenter : tr.txtTirms,
            style: textStyleAppBarTitle(),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(Get.context!);
            },
            icon: isArabicLang()
                ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
                : SvgPicture.asset("assets/svgs/back_arrow.svg"),
          ),
          centerTitle: true,
          backgroundColor: colorBackground,
        ),
        body: GetBuilder<ProfileViewModle>(
            init: ProfileViewModle(),
            initState: (con){
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                _emailController.text  =  SharedPref.instance
                    .getCurrentUserData().email.toString();
              });
            },
            builder: (logic) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding20!),
                      child: Column(children: [
                        SizedBox(height: sizeH50,),
                        CustomTextView(
                          textAlign: TextAlign.center,
                          txt: tr.txtFollow,
                          textStyle: textHelpFollow(),
                        ),
                        SizedBox(height: sizeH50,),
                        const SocialShareButtons(),
                        SizedBox(height: sizeH30,),
                        Container(
                          color: colorScaffoldRegistrationBody,
                          child: Column(
                            children: [
                              CustomTextView(
                                textAlign: TextAlign.center,
                                txt: tr.txtTechnicalSupport,
                                textStyle: textHelp(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: sizeH30,),
                        CustomTextFormFiled(
                          label: tr.txtFullNameScreen,
                          controller: TextEditingController(
                              text: SharedPref.instance
                                  .getCurrentUserData()
                                  .customerName),
                          hintStyle: TextStyle(
                              fontSize: 14, color: colorTextHint1),
                          maxLine: Constance.maxLineOne,
                          keyboardType: TextInputType.text,
                          onSubmitted: (_) {},
                          onChange: (value) {},
                          isReadOnly: true,
                          isSmallPadding: false,
                          isSmallPaddingWidth: true,
                          fillColor: colorBackground,
                          isFill: true,
                          isBorder: true,
                        ),
                        SizedBox(height: sizeH20,),
                        Form(
                          key: _globalKey,
                          child: Column(
                            children: [
                              CustomTextFormFiled(
                                controller: _emailController,
                                label: txtEmail!.tr,
                                maxLine: Constance.maxLineOne,
                                hintStyle: TextStyle(
                                    fontSize: 14, color: colorTextHint1),
                                keyboardType: TextInputType.text,
                                onSubmitted: (_) {},
                                onChange: (value) {},
                                // customValid: emailValid,
                                isSmallPadding: false,
                                isSmallPaddingWidth: true,
                                fillColor: colorBackground,
                                isFill: true,
                                isBorder: true,
                              ),
                              SizedBox(height: sizeH20,),
                              CustomTextFormFiled(
                                controller: _noteController,
                                label: tr.txtWriteHer,
                                maxLine: Constance.maxLineSaven,
                                minLine: 5,
                                hintStyle: TextStyle(
                                    fontSize: 14, color: colorTextHint1),
                                textInputAction: TextInputAction.newline,
                                // keyboardType: TextInputType.text,
                                onSubmitted: (_) {},
                                onChange: (value) {},
                                isSmallPadding: false,
                                isSmallPaddingWidth: true,
                                fillColor: colorBackground,
                                isFill: true,
                                isBorder: true,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: sizeH75),
                      ])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 9.5, left: 20.5, bottom: 33.5, top: 0),
                child: PrimaryButton(
                  isExpanded: true,
                  isLoading:logic.isLoading,
                  textButton: tr.send,
                  onClicked: ()=> _onSendNote(logic),
                ),
              )
            ],
          );
        }));
  }

  _onSendNote(ProfileViewModle logic) {
    bool isValidate = _globalKey.currentState!.validate();
    if(isValidate ){
      _globalKey.currentState!.save();
      logic.sendNote(_emailController , _noteController);
    }
  }
}
