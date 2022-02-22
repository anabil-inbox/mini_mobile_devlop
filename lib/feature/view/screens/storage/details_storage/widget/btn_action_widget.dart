import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance/constance.dart';

class BtnActionWidget extends StatelessWidget {
  final String? redBtnText, grayBtnText;
  final Function()? onRedBtnClick, onGrayBtnClick, onShareBox, onDeleteBox;
  final bool isShowingDeleteAndGivaway;
  final bool isGaveAway;
  final String boxStatus;

  const BtnActionWidget(
      {Key? key,
      this.redBtnText,
      this.grayBtnText,
      this.onRedBtnClick,
      required this.isGaveAway,
      required this.boxStatus,
      this.onShareBox,
      this.onDeleteBox,
      this.isShowingDeleteAndGivaway = false,
      this.onGrayBtnClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);

    if (isShowingDeleteAndGivaway) {
      return Row(
        children: [
          SizedBox(
            width: sizeW10,
          ),
          IconBtn(
            icon: "assets/svgs/share.svg",
            onPressed: () {
              onShareBox!();
            },
          ),
          SizedBox(
            width: sizeW10,
          ),
          Expanded(
            child: PrimaryButton(
                textButton: redBtnText ?? "${tr.recall}",
                isLoading: false,
                onClicked: onRedBtnClick ?? () {},
                isExpanded: true),
          ),
          SizedBox(
            width: sizeW10,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconBtn(
            icon: "assets/svgs/share.svg",
            onPressed: () {
              onShareBox!();
            },
          ),
          SizedBox(
            width: sizeW10,
          ),
          PrimaryButton(
              textButton: redBtnText ?? "${tr.recall}",
              isLoading: false,
              onClicked: onRedBtnClick ?? () {},
              width: sizeW114,
              isExpanded: false),
          SizedBox(
            width: sizeW5,
          ),
          boxStatus == LocalConstance.boxAtHome && isGaveAway
              ? const SizedBox()
              : PrimaryButton(
                  textButton: grayBtnText ?? "${tr.giveaway}",
                  isLoading: false,
                  onClicked: onGrayBtnClick ?? () {},
                  width: sizeW114,
                  isExpanded: false,
                  colorBtn: colorBtnGray,
                  colorText: colorTextDark,
                ),
          SizedBox(
            width: sizeW5,
          ),
          IconBtn(
            onPressed: () {
              onDeleteBox!();
            },
          ),
        ],
      );
    }
  }
}
