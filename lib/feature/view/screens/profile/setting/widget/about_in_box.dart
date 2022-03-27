import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_shaerd_data.dart';
import '../../../../../../util/app_style.dart';
import '../../../../../../util/constance.dart';
import '../../../../../../util/sh_util.dart';
import '../../../../../model/app_setting_modle.dart';
import '../../../../widgets/custome_text_view.dart';


class AboutInBox extends StatelessWidget {
  final bool? isAboutUs;

  const AboutInBox({
    Key? key,
    this.isAboutUs = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiSettings settings =
        ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));
    return Scaffold(
        backgroundColor: colorScaffoldRegistrationBody,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 1,
          title: Text(
            isAboutUs! ? tr.txt_about_inbox : tr.txtTirms,
            style: textStyleAppBarTitle(),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(Get.context!);
            },
            icon: isArabicLang()
                ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
                : SvgPicture.asset("assets/svgs/back_arrow.svg"),
          ),
          centerTitle: true,
          backgroundColor: colorBackground,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 24, left: 24, top: 26, bottom: 48),
            child: CustomTextView(
              maxLine: Constance.maxLineTwenty,
              textAlign: TextAlign.start,
              txt: "${tr.txt_about_inbox}",
              textStyle: textStyleSitting(),
            ),
          ),
        ));
  }
}


