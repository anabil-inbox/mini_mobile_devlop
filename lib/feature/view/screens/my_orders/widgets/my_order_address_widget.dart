import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class MyOrderAddressWidget extends StatelessWidget {
  const MyOrderAddressWidget({Key? key, required this.address})
      : super(key: key);

  final String address;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
    //  margin: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Row(
        children: [
          SizedBox(
            width: sizeW15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizeH22,
              ),
              Text("${tr.address}"),
              SizedBox(
                height: sizeH4,
              ),
              Text(
                address,
                style: textStyleHints()!.copyWith(fontSize: fontSize13),
              ),
              SizedBox(
                height: sizeH22,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
