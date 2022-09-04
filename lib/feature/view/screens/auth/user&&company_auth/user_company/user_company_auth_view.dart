import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/register/user_register_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/widget/header_login_widget.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/widget/shared_login_form_widget.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class UserCompanyLoginScreen extends GetWidget<IntroViewModle> {
  const UserCompanyLoginScreen({Key? key, required this.type})
      : super(key: key);

  final String type;
  AuthViewModle get authViewModel => Get.put(AuthViewModle());
  @override
  Widget build(BuildContext context) {
    screenUtil(context);

    return type != "${ConstanceNetwork.bothType}" ? Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          HeaderLogin(),
          SizedBox(
            height: sizeH22,
          ),
          type == "${ConstanceNetwork.userType}"
              ? Text("${tr.user_login}",
                  style: textStyleHints() ,textAlign: TextAlign.center)
              : Text("${tr.company_log_in}",
                  style: textStyleHints(),textAlign: TextAlign.center),
          SizedBox(
            height: sizeH10,
          ),
          type == "${ConstanceNetwork.userType}"
              ? Text(
                  "${tr.what_is_your_phone_number}",
                  style: textStyleHints(),textAlign: TextAlign.center,) : const SizedBox(),
            
             SizedBox(
            height: sizeH18,
          ),
         
         type == "${ConstanceNetwork.userType}" ||
         type == "${ConstanceNetwork.companyType}" ?
         SharedLoginForm(
            type: type,
          ):
         SizedBox(height: sizeH100,),
         SizedBox(height: sizeH240,),
         InkWell(
           splashColor: colorTrans,
           highlightColor: colorTrans,
              onTap: () {
                if (type == "${ConstanceNetwork.userType}") {
                  Get.off(() => UserRegisterScreen());
                  authViewModel.clearAllControllers();
                } else if (type == "${ConstanceNetwork.companyType}") {
                  Get.to(() => RegisterCompanyScreen());
                  authViewModel.clearAllControllers();
                } else {

                }
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: textStyleTitle(),
                  children: [
                    TextSpan(
                        text:
                            "${tr.dont_have_an_account}",
                        style: textStylePrimary()!.copyWith(color: colorTextHint,fontSize: 13),
                        
                        ),
                    TextSpan(
                        text:
                            "${tr.sign_up_here}",
                        style: textStylePrimary()!.copyWith(fontSize: 13)),
                  ],
                ),
              ),
            ),
        ],
      ),
    ) : UserBothLoginScreen();
  }
}
