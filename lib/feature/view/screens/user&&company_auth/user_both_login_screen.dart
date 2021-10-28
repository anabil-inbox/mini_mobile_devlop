import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/user&&company_auth/header_login.dart';
import 'package:inbox_clients/feature/view/screens/user&&company_auth/shared_login_form.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserBothLoginScreen extends StatelessWidget {
  const UserBothLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "${AppLocalizations.of(Get.context!)!.user_login}",
            style: textStyleHints(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: sizeH16,
          ),
          SharedLoginForm(type: "user"),
          SizedBox(height: sizeH20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW20!),
            child: SeconderyFormButton(
              buttonText: "${AppLocalizations.of(context)!.login_as_company}",
            ),
          )
        ],
      ),
    );
  }
}
