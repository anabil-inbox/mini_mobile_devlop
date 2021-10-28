import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:inbox_clients/feature/view/screens/auth_company/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth_user/user_register_screen.dart';
import 'package:inbox_clients/feature/view/screens/user&&company_auth/header_login.dart';
import 'package:inbox_clients/feature/view/screens/user&&company_auth/shared_login_form.dart';
import 'package:inbox_clients/feature/view/screens/user&&company_auth/user_both_login_screen.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/app_style.dart';

class UserCompanyLoginScreen extends GetWidget<IntroViewModle> {
  const UserCompanyLoginScreen({Key? key, required this.type})
      : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    Get.put(AuthViewModle());
    return type != "both" ? Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          HeaderLogin(),
          SizedBox(
            height: sizeH22,
          ),
          type == "user"
              ? Text("${AppLocalizations.of(Get.context!)!.user_login}",
                  style: textStyleHints() ,textAlign: TextAlign.center)
              : Text("${AppLocalizations.of(Get.context!)!.company_log_in}",
                  style: textStyleHints(),textAlign: TextAlign.center),
          SizedBox(
            height: sizeH10,
          ),
          type == "user"
              ? Text(
                  "${AppLocalizations.of(Get.context!)!.what_is_your_phone_number}",
                  style: textStyleHints(),textAlign: TextAlign.center,) : const SizedBox(),
            
             SizedBox(
            height: sizeH18,
          ),
         
         type == "user" ||
         type == "company" ? 
         SharedLoginForm(
            type: type,
          ): 
         SizedBox(height: sizeH100,),
         InkWell(
           splashColor: colorTrans,
           highlightColor: colorTrans,
              onTap: () {
                if (type == "user") {
                  Get.off(() => UserRegisterScreen());
                } else if (type == "company") {
                  Get.off(() => RegisterCompanyScreen());
                } else {

                }
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text:
                            "${AppLocalizations.of(Get.context!)!.dont_have_an_account}",
                        style: textStylePrimary()!.copyWith(color: colorBlack),
                        
                        ),
                    TextSpan(
                        text:
                            "${AppLocalizations.of(Get.context!)!.sign_up_here}",
                        style: textStylePrimary()),
                  ],
                ),
              ),
            ),
        ],
      ),
    ) : UserBothLoginScreen();
  }
}
