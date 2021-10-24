import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/sh_util.dart';

class TermsScreen extends StatelessWidget {
    const TermsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiSettings settings = ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));
    print("${settings.termOfConditions}");
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text("${AppLocalizations.of(Get.context!)!.terms_and_conditions}" , style: textStylePrimary(),),
        backgroundColor: colorTextWhite,
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeH20! , vertical: sizeH13!),
          child: CustomTextView(
            textAlign: TextAlign.start,
            txt: settings.termOfConditions,
          ),
        ),
      ),
      
    );
  }
}