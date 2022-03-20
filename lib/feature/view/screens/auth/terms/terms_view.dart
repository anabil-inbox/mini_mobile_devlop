import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/sh_util.dart';

class TermsScreen extends StatelessWidget {
  final bool? isAboutUs;
    const TermsScreen({ Key? key, this.isAboutUs = false,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    ApiSettings settings = ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text( isAboutUs! ? "${tr.about_inbox}" : "${tr.terms_and_conditions}" , style: textStyleAppBarTitle(),),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: isArabicLang()?SvgPicture.asset("assets/svgs/back_arrow_ar.svg"):SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeH20! , vertical: sizeH13!),
          child: CustomTextView(
            textAlign: TextAlign.start,
            txt: settings.termOfConditions == null ? "" : settings.termOfConditions,
            textStyle: textStyle(),
          ),
        ),
      ),
      
    );
  }
}