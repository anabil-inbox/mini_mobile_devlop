import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/register_company/header_register_company.dart';
import 'package:inbox_clients/feature/view/screens/register_company/widget/register_company_form.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/app_style.dart';

class RegisterCompanyScreen extends StatelessWidget {
  const RegisterCompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderRegisterCompany(),
            Container(
              color: colorUnSelectedWidget,
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
