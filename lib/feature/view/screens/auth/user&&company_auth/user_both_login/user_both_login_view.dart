import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/register/user_register_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/widget/header_login_widget.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/widget/shared_login_form_widget.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/sh_util.dart';

class UserBothLoginScreen extends StatelessWidget {
  const UserBothLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        print("msg_check ${GetUtils.isNull(SharedPref.instance.getCurrentUserData().id)}");

    Get.put(AuthViewModle());
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: ListView(
      padding: const EdgeInsets.all(0),
      children: [
          HeaderLogin(),
          SizedBox(
            height: sizeH16,
          ),
          Text(
            "${tr.user_login}",
            style: textStyleHints(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: sizeH7,
          ),
          Text(
            "${tr.what_is_your_phone_number}",
            style: textStyleHints(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: sizeH16,
          ),
          SharedLoginForm(type: "${ConstanceNetwork.userType}"),
          SizedBox(height: sizeH20,),
          SharedPref.instance.getUserType() == "${ConstanceNetwork.bothType}" ? Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW20!),
            child: SeconderyFormButton(
              buttonText: "${AppLocalizations.of(context)!.login_as_company}",
            ),
          ) : const SizedBox(),
          SizedBox(height: sizeH200,),
          InkWell(
            splashColor: colorTrans,
            highlightColor: colorTrans,
            onTap: (){
              Get.to(() => UserRegisterScreen());
            },
            child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: textStyleTitle(),
                    children: [
                      TextSpan(
                          text:
                              "${tr.dont_have_an_account} ",
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
          SizedBox(height: 16,),
        ],
      ),
    );
  }
}
