import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inbox_clients/feature/view/screens/profile/log/log_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/my_rewareds/my_rewards_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/payment_card/payment_card_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/setting/setting_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/header_profile_card.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/setting_item.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/setting_item_with_title.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'address/get_address.dart';
import 'my_wallet/my_wallet_screen.dart';

class ProfileScreen extends GetWidget<ProfileViewModle> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileViewModle>(
          init: ProfileViewModle(),
          builder: (logic) {
            return Column(
              children: [
                HeaderProfileCard(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      SizedBox(
                        height: sizeH12,
                      ),
                      SettingItemWithTitle(
                        onTap: () {
                          Get.to(() => MyWalletScreen());
                        },
                        trailingTitle: "0 QAR",
                        settingTitle: "${tr.my_wallet}",
                        iconPath: "assets/svgs/wallet.svg",
                      ),
                      SizedBox(
                        height: sizeH12,
                      ),
                      SettingItemWithTitle(
                        onTap: () {
                          Get.to(() => MyRewardsScreen());
                        },
                        trailingTitle: "0 ${tr.point}",
                        settingTitle: "${tr.my_rewards}",
                        iconPath: "assets/svgs/rewareds.svg",
                      ),
                      SizedBox(
                        height: sizeH12,
                      ),
                      SettingItem(
                        onTap: () {
                          changeLanguageBottomSheet();
                        },
                        trailingTitle: "",
                        settingTitle: "${tr.language}",
                        iconPath: "assets/svgs/language_profile.svg",
                      ),
                      SizedBox(
                        height: sizeH12,
                      ),
                      SettingItem(
                        onTap: () {
                          Get.to(() => GetAddressScreen());
                        },
                        settingTitle: "${tr.my_address}",
                        trailingTitle: "",
                        iconPath: "assets/svgs/adress_icon.svg",
                      ),
                      SizedBox(
                        height: sizeH12,
                      ),
                      SettingItem(
                        onTap: () {
                          Get.to(() => PaymentCardScreen());
                        },
                        settingTitle: "${tr.payment_card}",
                        trailingTitle: "",
                        iconPath: "assets/svgs/payment_card.svg",
                      ),
                      SizedBox(
                        height: sizeH12,
                      ),
                      SettingItem(
                        onTap: () {
                          Get.to(() => LogScreen());
                        },
                        settingTitle: "${tr.log}",
                        trailingTitle: "",
                        iconPath: "assets/svgs/log_icon.svg",
                      ),
                      SizedBox(
                        height: sizeH12,
                      ),
                      SettingItem(
                        onTap: () {
                          Get.to(() => SettingsScreen());
                        },
                        settingTitle: "${tr.setting}",
                        trailingTitle: "",
                        iconPath: "assets/svgs/setting.svg",
                      ),
                      SizedBox(
                        height: sizeH12,
                      ),
                      SettingItem(
                        onTap: () {
                          controller.logOutDiloag();
                        },
                        settingTitle: "${tr.log_out}",
                        trailingTitle: "",
                        iconPath: "assets/svgs/logout.svg",
                      ),
                      SizedBox(
                        height: sizeH40,
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
