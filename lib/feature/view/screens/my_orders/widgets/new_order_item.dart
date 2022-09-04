import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class NewOrderItemTask extends StatelessWidget {
  const NewOrderItemTask(
      {Key? key, required this.index, required this.orderItem})
      : super(key: key);
  final int index;
  final OrderItem orderItem;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding6!),
        color: colorBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sizeH16!),
          index == 0
              ? Row(
                  children: [
                    SvgPicture.asset("assets/svgs/folder_icon.svg"),
                    SizedBox(
                      width: sizeW10,
                    ),
                    Text(
                      orderItem.itemName != null ? orderItem.itemName.toString().replaceAll("_", " ").toString().replaceAll("-", ""): "",
                      style: textStyleMeduimPrimaryText()!.copyWith(
                        fontSize: fontSize16,
                      ),
                    )
                  ],
                )
              : const SizedBox(),
          index == 0 ? SizedBox(height: sizeH16!) : const SizedBox(),
          index == 0
              ? Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: padding16!, right: padding16!),
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        childAspectRatio: (2 / 0.4)),
                    itemCount: orderItem.boxes?.length,
                    itemBuilder: (context, index) {
                      return Text(orderItem.boxes?[index] ?? "");
                    },
                  ),
                )
              : const SizedBox(),
          index == 0 ? SizedBox(height: sizeH16!) : const SizedBox(),
          index == 0
              ? Row(
                  children: [
                    Text(tr.totaldots),
                    const Spacer(),
                    Text(
                      getPriceWithFormate(price: orderItem.totalPrice ?? 0),
                      style: textStylePrimary()!.copyWith(fontSize: fontSize16),
                    ),
                  ],
                )
              : const SizedBox(),
          index == 0 ? SizedBox(height: sizeH16!) : const SizedBox(),
        ],
      ),
    );
  }
}
