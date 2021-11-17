import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/get_address.dart';
import 'package:inbox_clients/feature/view/screens/profile/setting/setting_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/header_profile_card.dart';
import 'package:inbox_clients/feature/view/screens/profile/widget/setting_item.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends GetWidget<ProfileViewModle> {
  const ProfileScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderProfileCard(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                SizedBox(height: sizeH12,),  
                SettingItem(
                  onTap: (){
                   
                  },
                  trailingTitle: "0 QAR",
                  settingTitle: "${AppLocalizations.of(context)!.my_wallet}",
                  iconPath: "assets/svgs/wallet.svg",
                ),
                SizedBox(height: sizeH12,),  
                SettingItem(
                  onTap: (){
                   
                  },
                  trailingTitle: "0 point",
                  settingTitle: "${AppLocalizations.of(context)!.my_rewards}",
                  iconPath: "assets/svgs/rewareds.svg",
                ),
                SizedBox(height: sizeH12,), 
                SettingItem(
                  onTap: (){
                   changeLanguageBottomSheet();
                  },
                  trailingTitle: "",
                  settingTitle: "${AppLocalizations.of(context)!.language}",
                  iconPath: "assets/svgs/language_profile.svg",
                ),
                SizedBox(height: sizeH12,), 
                SettingItem(
                  onTap: (){
                  //  Get.to(() => GetAddressScreen());
                  },
                  settingTitle: "${AppLocalizations.of(context)!.my_address}",
                  trailingTitle: "",
                  iconPath: "assets/svgs/adress_icon.svg",
                ),
                SizedBox(height: sizeH12,), 
                SettingItem(
                  onTap: (){
                   
                  },
                  settingTitle: "${AppLocalizations.of(context)!.payment_card}",
                  trailingTitle: "",
                  iconPath: "assets/svgs/payment_card.svg",
                ),
                SizedBox(height: sizeH12,), 
                SettingItem(
                  onTap: (){
                    
                  },
                  settingTitle: "${AppLocalizations.of(context)!.log}",
                  trailingTitle: "",
                  iconPath: "assets/svgs/log_icon.svg",
                ),
                SizedBox(height: sizeH12,), 
                SettingItem(
                  onTap: (){
                  //  Get.to(() => SettingsScreen());
                  },
                  settingTitle: "${AppLocalizations.of(context)!.setting}",
                  trailingTitle: "",
                  iconPath: "assets/svgs/setting.svg",
                ),
                SizedBox(height: sizeH12,),  
                SettingItem(
                  onTap: (){
                    controller.logOutDiloag();
                  },
                  settingTitle: "${AppLocalizations.of(context)!.log_out}",
                  trailingTitle: "",
                  iconPath: "assets/svgs/logout.svg",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}