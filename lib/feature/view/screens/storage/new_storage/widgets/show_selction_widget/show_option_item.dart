import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class ShowOptionItem extends StatelessWidget {
  const ShowOptionItem({Key? key , required this.optionTitle}) : super(key: key);

  final String optionTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset("assets/svgs/true_without_background.svg"),
            SizedBox(width: sizeW7),
            Text(
              "$optionTitle",
              style: smallHintTextStyle()?.copyWith(fontSize: fontSize13),
            ),
            const Spacer(),
            Text("12 QR" , style: textStylePrimarySmall(),)
          ],
        ),
        SizedBox(height: sizeH12,)
      ],
    );
  }
}
