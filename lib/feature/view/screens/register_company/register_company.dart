import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/register_company/header_register_company.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterCompanyScreen extends StatelessWidget {
  const RegisterCompanyScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderRegisterCompany(),
          SizedBox(height: sizeH16,),
          Text("${AppLocalizations.of(Get.context!)!.company_registration}")
        ],
      ),
    );
  }
}