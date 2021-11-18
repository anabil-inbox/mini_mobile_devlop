import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/widget/shared_login_form_widget.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/sh_util.dart';

import '../widget/header_login_widget.dart';

class CompanyBothLoginScreen extends GetWidget<AuthViewModle> {
  const CompanyBothLoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          HeaderLogin(),         
          SizedBox(
            height: sizeH16,
          ),
          Text(
            "${AppLocalizations.of(Get.context!)!.company_log_in}",
            style: textStyleHints(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: sizeH7,
          ),
          Text(
          "${AppLocalizations.of(Get.context!)!.what_is_your_cr_number}",
          style: textStyleHints(),
          textAlign: TextAlign.center,
          ),
          SizedBox(height: sizeH13,),
          SharedLoginForm(type: "${ConstanceNetwork.companyType}"),
          SizedBox(height: sizeH20,),
         SharedPref.instance.getUserType() == "${ConstanceNetwork.bothType}" ? Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW20!),
            child: SeconderyFormButton(
              buttonText: "${AppLocalizations.of(context)!.login_as_user}",
            ),
          ): const SizedBox(),
           SizedBox(height: 200,),
          InkWell(
            splashColor: colorTrans,
            highlightColor: colorTrans,
            onTap: (){
              Get.put(AuthViewModle());
              Get.to(() => RegisterCompanyScreen());
            },
            child: RichText(
                  
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: textStyleTitle(),
                    children: [
                      TextSpan(
                          text:
                              "${AppLocalizations.of(Get.context!)!.dont_have_an_account} ",
                          style: textStylePrimary()!.copyWith(color: colorTextHint,fontSize: 13),
                          
                          ),
                      TextSpan(
                          text:
                              "${AppLocalizations.of(Get.context!)!.sign_up_here}",
                          style: textStylePrimary()!.copyWith(fontSize: 13)),
                    ],
                  ),
                ),
            
          ),
          SizedBox(height: sizeH16,),
        
        ]
        ,
      ),
    );
  
  }
}