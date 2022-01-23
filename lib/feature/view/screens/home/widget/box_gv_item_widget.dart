import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/notifay_for_new_storage.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/date_time_util.dart';

class HomeGVItemWidget extends StatelessWidget {
  const HomeGVItemWidget({Key? key, required this.box, this.isEnabeld = true})
      : super(key: key);
  final Box box;
  final bool isEnabeld;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: sizeW165,
      height: sizeH150,
      padding: EdgeInsets.all(padding10!),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(sizeRadius5!),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: padding0,
            bottom: padding0,
            start: padding0,
            end: padding0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                retuenBoxByStatus(storageStatus: box.storageStatus ?? "" , isEnabeld: isEnabeld),
                SizedBox(
                  height: sizeH10,
                ),
                CustomTextView(
                  txt: "${box.storageName}",
                  maxLine: Constance.maxLineTwo,
                  textStyle: textStyleNormalBlack(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: sizeH9,
                ),
                CustomTextView(
                  txt: "${DateUtility.getChatTime(box.modified.toString())}",
                  maxLine: Constance.maxLineOne,
                  textStyle: textStyleNormal(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          PositionedDirectional(
            end: padding0,
            top: padding10! * -1,
            child: SizedBox(
              width: sizeW40,
              child: Tooltip(
                message: "${box.serialNo}",
                child: TextButton(
                  onPressed: () {
                   // if (isEnabeld) {
                      Get.bottomSheet(NotifayForNewStorage(box: box),
                          isScrollControlled: true);
                  //  }
                  },
                  child: SvgPicture.asset("assets/svgs/InfoCircle.svg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
