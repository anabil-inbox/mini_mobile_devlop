import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/date_time_util.dart';

class HomeGVItemWidget extends StatelessWidget {
  const HomeGVItemWidget({Key? key, required this.box}) : super(key: key);
  final Box box;

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
            top: 0,
            bottom: 0,
            start: 0,
            end: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                retuenBoxByStatus(storageStatus: box.storageStatus ?? ""),
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
                  txt: "${DateUtility.getChatTime(box.modified ?? "")}",
                  maxLine: Constance.maxLineOne,
                  textStyle: textStyleNormal(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          PositionedDirectional(
            end: 0,
            top: -10,
            child: SizedBox(
              width: sizeW40,
              child: Tooltip(
                message: "${box.serialNo}",
                child: TextButton(
                  onPressed: () {},
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
