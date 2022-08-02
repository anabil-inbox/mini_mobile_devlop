import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../../../../../../util/app_shaerd_data.dart';

class MapTypeItem extends StatelessWidget {
  const MapTypeItem({Key? key, required this.buttonText}) : super(key: key);

  final String buttonText;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<ProfileViewModle>(
      initState: (con){
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          con.controller?.selectedMapType = LocalConstance.bluePlate;
          con.controller?.update();
        });
      },
      builder: (builder) {
        return InkWell(
          onTap: () {
            builder.selectedMapType = buttonText;
            builder.update();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: padding4!),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(padding6!),
                border: Border.all(
                    width: 0.5,
                    color: builder.selectedMapType != buttonText
                        ? colorBorderContainer
                        : colorTrans),
                color: builder.selectedMapType != buttonText
                    ? colorTextWhite
                    : colorPrimary),
            padding: EdgeInsets.symmetric(
                vertical: padding9!, horizontal: padding14!),
            child: CustomTextView(
              txt: "$buttonText",
              textStyle: builder.selectedMapType == buttonText
                  ? textStylebodyWhite()
                  : textStyleHints()!
                      .copyWith(fontSize: fontSize14, color: colorHint2),
            ),
          ),
        );
      },
    );
  }
}
