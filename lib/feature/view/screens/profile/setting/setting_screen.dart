import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/view/screens/auth/terms/terms_view.dart';
import 'package:inbox_clients/feature/view/screens/profile/setting/user_guid_view.dart';
import 'package:inbox_clients/feature/view/screens/profile/setting/widget/about_in_box.dart';
import 'package:inbox_clients/feature/view/screens/profile/setting/widget/help_center/help_center_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/setting_item_no_padding.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'package:inbox_clients/util/app_shaerd_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          "${tr.setting}",
          style: textStyleAppBarTitle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: isArabicLang()?SvgPicture.asset("assets/svgs/back_arrow_ar.svg"):SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: sizeH20,
          ),
          SettingItemNoPadding(settingTitle: "${tr.helpCenter}", onTap: (){
            Get.to(() => const HelpCenterScreen(
              helpCenter: true,
            ));
          }),
           SizedBox(
            height: sizeH16,
          ),
          SettingItemNoPadding(settingTitle: "${tr.about_inbox}", onTap: (){

            Get.to(() => const AboutInBox(
              isAboutUs: true,
            ));
          }),
           SizedBox(
            height: sizeH16,
          ),
          SettingItemNoPadding(settingTitle: "${tr.terms_and_conditions}", onTap: (){
            Get.to(() => TermsScreen());
          }),
          SizedBox(
            height: sizeH16,
          ),
          SettingItemNoPadding(settingTitle: "${tr.user_guid}", onTap: (){
            Get.to(() => UserGuidView());
          }),
        ],
      ),
    );
  }
}
