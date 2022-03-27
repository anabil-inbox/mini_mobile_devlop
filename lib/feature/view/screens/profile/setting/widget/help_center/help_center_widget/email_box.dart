import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../../../../util/app_color.dart';
import '../../../../../../../../util/app_dimen.dart';
import '../../../../../../../../util/app_shaerd_data.dart';
import '../../../../../../../../util/constance.dart';
import '../../../../../../../../util/string.dart';
import '../../../../../../widgets/custom_text_filed.dart';

class Email extends StatelessWidget {
  const Email({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding4!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormFiled(
            label: txtEmail!.tr,
            maxLine: Constance.maxLineOne,
            hintStyle:   TextStyle(fontSize: 14,color: colorTextHint1),
            keyboardType: TextInputType.text,
            onSubmitted: (_) {},
            onChange: (value) {},
            isSmallPadding: false,
            isSmallPaddingWidth: true,
            fillColor: colorBackground,
            isFill: true,
            isBorder: true,
          ),
        ],
      ),
    );
  }
}