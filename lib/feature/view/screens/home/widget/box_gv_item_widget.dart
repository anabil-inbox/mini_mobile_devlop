import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

class HomeGVItemWidget extends StatelessWidget {
  const HomeGVItemWidget({Key? key, this.boxPath}) : super(key: key);
  final String? boxPath;

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
                SvgPicture.asset(
                  boxPath??"assets/svgs/desable_box.svg",
                  width: sizeW50,
                  height: sizeH40,
                ),
                SizedBox(
                  height: sizeH10,
                ),
                CustomTextView(
                  txt: "New Box 01",
                  maxLine: Constance.maxLineTwo,
                  textStyle: textStyleNormalBlack(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: sizeH9,
                ),
                CustomTextView(
                  txt: "Yesterday",
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
              child: TextButton(
                onPressed: () {},
                child: SvgPicture.asset("assets/svgs/InfoCircle.svg"),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
