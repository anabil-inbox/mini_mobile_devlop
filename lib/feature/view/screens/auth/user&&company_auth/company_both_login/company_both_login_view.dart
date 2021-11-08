import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/widget/shared_login_form_widget.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW20!),
            child: SeconderyFormButton(
              buttonText: "${AppLocalizations.of(context)!.login_as_user}",
            ),
          ),
        ],
      ),
    );
  
  }
}