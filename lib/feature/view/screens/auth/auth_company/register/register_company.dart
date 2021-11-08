import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/widget/register_company_form_widget.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../widget/header_register_company_widget.dart';

class RegisterCompanyScreen extends GetWidget<AuthViewModle> {
  const RegisterCompanyScreen({Key? key}) : super(key: key);
  //AuthViewModle get viewModel => Get.find<AuthViewModle>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderRegisterCompany(
              onBackPressed: (){
                Get.back();
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
                      "${AppLocalizations.of(Get.context!)!.company_registration}" , style: textStyleHints(),),
                  SizedBox(
                    height: sizeH16,
                  ),
                  RegisterCompanyForm()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
