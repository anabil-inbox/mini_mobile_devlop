import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class BoxInSalesOrder extends StatelessWidget {
  const BoxInSalesOrder({Key? key, required this.box}) : super(key: key);

  final Box box;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizeH22,
        ),
        SvgPicture.asset("assets/svgs/folder_icon.svg"),
        SizedBox(
          height: sizeH6,
        ),
        Text("${box.storageName}"),
        SizedBox(
          height: sizeH2,
        ),
        Text(
          "${box.storageStatus}",
          style: textStyleHints()!.copyWith(fontSize: fontSize13),
        ),
        SizedBox(
          height: sizeH20,
        ),
      ],
    );
  }
}
