import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/view/screens/auth/terms/terms_view.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/setting_item_no_padding.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          "${AppLocalizations.of(Get.context!)!.setting}",
          style: textStyleAppBarTitle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: sizeH20,
          ),
          SettingItemNoPadding(
              settingTitle: "${AppLocalizations.of(context)!.helpCenter}",
              onTap: () {}),
          SizedBox(
            height: sizeH16,
          ),
          SettingItemNoPadding(
              settingTitle: "${AppLocalizations.of(context)!.about_inbox}",
              onTap: () {
                Get.to(() => TermsScreen(isAboutUs: true,));
              }),
          SizedBox(
            height: sizeH16,
          ),
          SettingItemNoPadding(
              settingTitle:
                  "${AppLocalizations.of(context)!.terms_and_conditions}",
              onTap: () {
                Get.to(() => TermsScreen());
              }),
        ],
      ),
    );
  }
}
