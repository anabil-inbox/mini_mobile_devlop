import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      alignment: Alignment.center,
      width: sizeW165,
      height: sizeH160,
      padding: EdgeInsets.all(padding10!),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(sizeRadius5!),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageNetwork(
              height: sizeH80,
              width: sizeW95,
              url: "https://www.celladorales.com/wp-content/uploads/2016/12/ShippingBox_sq.jpg",
              fit: BoxFit.cover
          ),
          SizedBox(
            height: sizeH10,
          ),
          CustomTextView(
            txt: "{box.storageName}",
            maxLine: Constance.maxLineTwo,
            textStyle: textStyleNormalBlack(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: sizeH9,
          ),
          CustomTextView(
            txt: "{DateUtility.getChatTime(box.modified.toString())}",
            maxLine: Constance.maxLineOne,
            textStyle: textStyleNormal(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
