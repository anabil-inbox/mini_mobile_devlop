import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import 'order_detailes_widgets/option_detailes.dart';

class MyOrderBoxItem extends StatelessWidget {
  const MyOrderBoxItem({Key? key, required this.orderItem}) : super(key: key);

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      margin: EdgeInsets.only(bottom: padding10!),
      padding: EdgeInsets.symmetric(vertical: padding10!),
      decoration: BoxDecoration(
        color: colorBackground,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: sizeW10,
              ),
              SvgPicture.asset("assets/svgs/folder_icon.svg"),
              SizedBox(
                width: sizeW10,
              ),
              SizedBox(width: sizeW200, child: Text(orderItem.item ?? "")),
              const Spacer(),
              Column(
                children: [
                  SizedBox(
                    height: sizeH16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(padding6!),
                      color: scaffoldColor,
                    ),
                    padding: EdgeInsets.all(padding7!),
                    child: Text(
                      "X ${orderItem.quantity?.toInt()}",
                      style:
                          textStylePrimarySmall()!.copyWith(color: colorBlack),
                    ),
                  ),
                  // SizedBox(
                  //   height: sizeH16,
                  // ),
                  // Container(
                  //   color: colorBackground,
                  //   child: Text(
                  //     getPriceWithFormate(price: orderItem.totalPrice ?? 0),
                  //     style: textStylePrimarySmall(),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                width: sizeW15,
              ),
            ],
          ),
          SizedBox(
            height: sizeH10,
          ),
          OptionDeatailes(
            orderItem: orderItem,
          ),
          SizedBox(
            height: sizeH10,
          ),
          Row(
            children: [
              SizedBox(
                width: sizeW15,
              ),
              Text("Total:"),
              const Spacer(),
              Text(
                getPriceWithFormate(price: orderItem.totalPrice ?? 0),
                style: textStylePrimary()!.copyWith(fontSize: fontSize16),
              ),
              SizedBox(
                width: sizeW15,
              ),
            ],
          ),
          SizedBox(
            height: sizeH4,
          )
        ],
      ),
    );
  }
}
