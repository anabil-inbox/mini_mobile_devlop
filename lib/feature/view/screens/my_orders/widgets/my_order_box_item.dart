import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import 'order_detailes_widgets/option_detailes.dart';

class MyOrderBoxItem extends StatelessWidget {
  const MyOrderBoxItem({Key? key , required this.orderSales}) : super(key: key);

  final OrderSales orderSales;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(orderSales.orderType ?? ""),
            ],
          ),
          SizedBox(
            height: sizeH10,
          ),
          OptionDeatailes(orderSales: orderSales,)
        ],
      ),
    );
  }
}
