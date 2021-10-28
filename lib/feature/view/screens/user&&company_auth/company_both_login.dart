import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/user&&company_auth/shared_login_form.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'header_login.dart';

class CompanyBothLoginScreen extends StatelessWidget {
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
            height: sizeH16,
          ),
          SharedLoginForm(type: "company"),
          SizedBox(height: sizeH20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW20!),
            child: SeconderyFormButton(
              buttonText: "${AppLocalizations.of(context)!.login_as_user}",
            ),
          )
        ],
      ),
    );
  
  }
}