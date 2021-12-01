import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class BtnActionWidget extends StatelessWidget {
  final String? redBtnText ,grayBtnText;
  final Function()? onRedBtnClick , onGrayBtnClick ;
  const BtnActionWidget({Key? key, this.redBtnText, this.grayBtnText, this.onRedBtnClick, this.onGrayBtnClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PrimaryButton(
            textButton: redBtnText??"${tr.recall}",
            isLoading: false,
            onClicked: onRedBtnClick??() {},
            width: sizeW135,
            isExpanded: false),
        SizedBox(
          width: sizeW10,
        ),
        PrimaryButton(
          textButton: grayBtnText??"${tr.giveaway}",
          isLoading: false,
          onClicked: onGrayBtnClick??() {},
          width: sizeW135,
          isExpanded: false,
          colorBtn: colorBtnGray,
          colorText: colorTextDark,
        ),
        SizedBox(
          width: sizeW10,
        ),
        IconBtn(),
      ],
    );
  }
}
