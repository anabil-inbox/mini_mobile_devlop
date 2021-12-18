
import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/core/loading.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/string.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Dialog(
      insetPadding: EdgeInsets.all(sizeH20!),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sizeRadius!),
      ),
      backgroundColor: colorTrans,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sizeW10!, vertical: sizeH10!),
        width: sizeW100,
        height: sizeH120,
        margin: EdgeInsets.symmetric(horizontal: sizeW70!),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sizeRadius!),
          color: colorBackground,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           // Loading(),
           ThreeSizeDot(
             color_1: colorPrimary,
             color_2: colorPrimary,
             color_3: colorPrimary,
           ),
            SizedBox(height: sizeH17,),
            CustomTextView(
              textAlign:TextAlign.center ,
              maxLine: 1,
              textOverflow: TextOverflow.ellipsis,
              txt: txtWait!,
            ),
          ],
        ),
      ),
    );
  }
}
