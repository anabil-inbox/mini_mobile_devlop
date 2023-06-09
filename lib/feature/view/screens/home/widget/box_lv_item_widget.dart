import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/notifay_for_new_storage.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/date_time_util.dart';

class HomeLVItemWidget extends StatelessWidget {
  const HomeLVItemWidget({Key? key, required this.box, this.isEnabeld = true})
      : super(key: key);

  final Box box;
  final bool isEnabeld;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      // height: sizeH75,
      padding: EdgeInsets.all(padding18!),
      margin: EdgeInsets.only(bottom: sizeH10!),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(sizeRadius5!),
      ),
      child: Row(
        children: [
          returnBoxByStatus(
              isPickup: box.isPickup ?? true,
              storageStatus: box.storageStatus ?? "", isEnabeld: isEnabeld),
          SizedBox(
            width: sizeW15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextView(
                  txt: "${box.storageName}",
                  maxLine: Constance.maxLineOne,
                  textStyle: textStyleNormalBlack()?.copyWith(height: 1),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: sizeH2,
                ),
                if(box.saleOrder != null)...[
                  CustomTextView(
                    txt: "${box.saleOrder ?? ""}",
                    maxLine: Constance.maxLineOne,
                    textStyle: textStyleNormal()?.copyWith(height: 1),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: sizeH2,
                  ),
                ],
                CustomTextView(
                  txt: "${DateUtility.getChatTime(box.modified.toString())}",
                  maxLine: Constance.maxLineOne,
                  textStyle: textStyleNormal()?.copyWith(height: 1),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            width: sizeW40,
            child: Tooltip(
              message: "${box.serialNo}",
              child: TextButton(
                onPressed: () {
                  Get.bottomSheet(NotifayForNewStorage(box: box),
                      isScrollControlled: true);
                },
                child: SvgPicture.asset("assets/svgs/InfoCircle.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
