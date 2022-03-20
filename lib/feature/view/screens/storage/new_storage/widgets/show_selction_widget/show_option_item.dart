import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class ShowOptionItem extends StatelessWidget {
  const ShowOptionItem(
      {Key? key,
      required this.optionTitle,
      this.isShowingPrice = false,
      this.price = ""})
      : super(key: key);

  final String optionTitle;
  final bool isShowingPrice;
  final String price;

  Widget get priceWidget {
    if (isShowingPrice) {
      return Text(formatStringWithCurrency(price , "") , style: textStylePrimarySmall(),);
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset("assets/svgs/true_without_background.svg"),
            SizedBox(width: sizeW7),
            Container(
              width: sizeW190,
              child: Text(
                "$optionTitle",
                style: smallHintTextStyle()?.copyWith(fontSize: fontSize13),
                maxLines: Constance.maxLineTwo,
              ),
            ),
            const Spacer(),
            priceWidget,
            SizedBox(width: sizeW10),
          ],
        ),
        SizedBox(
          height: sizeH12,
        ),
      ],
    );
  }
}
