import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../../../../util/app_shaerd_data.dart';

class LogRecallItem extends StatelessWidget {
  const LogRecallItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH22,
          ),
          SvgPicture.asset("assets/svgs/folder_icon.svg"),
          SizedBox(
            height: sizeH12,
          ),
           RichText(
            text: TextSpan(
              style: textStyleNormal(),
              children: [
                TextSpan(
                  text: 'You Recalled',
                ),
                TextSpan(
                  text: ' New Box 01 ',
                  style: textStylebodyBlack()
                ),
                TextSpan(
                  text: 'for Collection',
                ),
              ],
            ),
          ),
         // Text("You stored Meeting Notes in New Box 01"),
          SizedBox(
            height: sizeH5,
          ),
          Text(
            "Yesterday at 3:31pm",
            style: textStyleHints(),
          ),
          SizedBox(
            height: sizeH10,
          ),
          Row(
            children: [
              PrimaryButton(
                textButton: "Cancel",
                isLoading: false,
                onClicked: () {},
                isExpanded: false,
                width: sizeW120,
              ),
              SizedBox(
                width: sizeW10,
              ),
              Expanded(child: SeconderyFormButton(buttonText: "Reschedule", onClicked: (){})),
              SizedBox(width: sizeW50,)
            ],
          ),
          SizedBox(
            height: sizeH12,
          ),
        ],
      ),
    );
  }
}
