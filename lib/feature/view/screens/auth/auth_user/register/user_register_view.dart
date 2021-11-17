import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/widget/header_register_company_widget.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/widget/register_user_form_widget.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/app_style.dart';

class UserRegisterScreen extends GetWidget<AuthViewModle> {
  const UserRegisterScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthViewModle());
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderRegisterCompany(
              onBackPressed: (){
                print("object");
                Get.offAll(() => UserBothLoginScreen());
              },
            ),
            Container(
              color: colorScaffoldRegistrationBody,
              child: Column(
                children: [
                  SizedBox(
                    height: sizeH16,
                  ),
                  Text(
                      "${AppLocalizations.of(Get.context!)!.user_registration}" , style: textStyleHints(),),
                  SizedBox(
                    height: sizeH16,
                  ),
                  RegisterUserForm()
                ],
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}