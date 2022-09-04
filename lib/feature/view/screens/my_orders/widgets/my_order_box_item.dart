import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

import 'order_detailes_widgets/option_detailes.dart';

class MyOrderBoxItem extends StatelessWidget {
  const MyOrderBoxItem({Key? key, required this.orderItem,required this.sealOrder, }) : super(key: key);

  final OrderItem orderItem;
  final OrderSales sealOrder;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    Logger().w(orderItem.storageType);
    return Container(
      margin: EdgeInsets.only(bottom: padding10!),
      padding: EdgeInsets.symmetric(vertical: padding10!),
      decoration: BoxDecoration(
        color: colorBackground,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(width: sizeW200, child: Text(boxNameHandler())),

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
          if(orderItem.storageType?.toLowerCase() == LocalConstance.quantityConst.toLowerCase() /*||
              orderItem.storageType == LocalConstance.newStorageItemSv ||
              orderItem.storageType == LocalConstance.newNewStorageSpaceSv*/)...[
            SizedBox(
              height: sizeH10,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: sizeW12!),
              child: Row(
                children: [
                  Expanded(child: Text("${tr.subscriptions} : ${orderItem.subscriptionType.toString()}")),
                  Text("(${handlerQtySubscriptions()}${orderItem.subscriptionDuration})")
                ],
              ),
            ),
          ],

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
              Text(tr.totaldots),
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

  String boxNameHandler() {
    return "${orderItem.itemName != null && orderItem.itemName.toString().isNotEmpty ? orderItem.itemName : orderItem.item != null ? orderItem.item.toString().replaceAll("_", " ").toString().replaceAll("-", " ") : ""}";
  }
  String handlerQtySubscriptions() {
    return orderItem.subscriptionType.toString() == LocalConstance.dailySubscriptions ?" ${tr.daily} " : "".trim();
  }
}
