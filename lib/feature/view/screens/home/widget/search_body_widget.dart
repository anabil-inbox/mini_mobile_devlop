import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class SearchBodyWidget extends StatelessWidget {
  const SearchBodyWidget({Key? key, required this.item, required this.date})
      : super(key: key);

  final BoxItem item;
  final DateTime? date;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              child: imageNetwork(
                  height: sizeH44,
                  width: sizeW44,
                  url: item.itemGallery!.isEmpty ? urlPlacholder :
                    "${ConstanceNetwork.imageUrl}${(item.itemGallery?[0].attachment ?? urlPlacholder)}"),
            ),
            SizedBox(
              width: sizeW7,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${item.itemName}"),
                Text(
                  date == null ? "" : DateUtility.getChatTime(date.toString()),
                  style: textStyleHints()!.copyWith(fontSize: fontSize13),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: sizeH16,
        )
      ],
    );
  }
}
