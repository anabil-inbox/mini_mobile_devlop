import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:logger/logger.dart';

import '../../../../../../util/app_shaerd_data.dart';

class AreaZoneWidget extends StatelessWidget {
  const AreaZoneWidget({Key? key, required this.areaZone}) : super(key: key);

  final AreaZone areaZone;
  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.only(bottom: padding10!),
      child: SeconderyFormButton(
          buttonText: "${areaZone.areaZone}",
          onClicked: () {
            profileViewModle.userAreaZone = areaZone;
            profileViewModle.tdZone.text = areaZone.areaZone ?? "";
            Logger().d(areaZone.toJson());
            Get.back();
            profileViewModle.update();
          }),
    );
  }
}
