import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/order_details_screen.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class MyOrderItem extends StatelessWidget {
  const MyOrderItem({Key? key, required this.orderSales}) : super(key: key);

  final OrderSales orderSales;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: colorTrans,
      highlightColor: colorTrans,
      onTap: () {
        Get.to(() => OrderDetailesScreen(
              orderSales: orderSales,
            ));
      },
      child: Column(
        children: [
          Container(
            height: sizeH90,
            color: colorBackground,
            margin: EdgeInsets.symmetric(horizontal: padding20!),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: sizeW15,
                ),
                SvgPicture.asset("assets/svgs/folder_seconder.svg"),
                SizedBox(
                  width: sizeW10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${orderSales.orderId}",
                      style: textStyleMeduimBlackText(),
                    ),
                    SizedBox(
                      height: sizeH4,
                    ),
                    Text(
                      "${orderSales.orderShippingAddress ?? orderSales.orderWarehouseAddress ?? ""}",
                      style: textStyleHints()!.copyWith(fontSize: fontSize13),
                    ),
                    SizedBox(
                      height: sizeH4,
                    ),
                    Text(
                        "${DateUtility.getChatTime(orderSales.deliveryDate.toString())}",
                        style:
                            textStyleHints()!.copyWith(fontSize: fontSize13)),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: sizeH10,
                    ),
                    CustomTextView(txt: "${orderSales.totalPrice}  "),
                    TextButton(
                        clipBehavior: Clip.none,
                        style: buttonStyleBackgroundClicable,
                        onPressed: () {},
                        child: CustomTextView(
                          txt: "${orderSales.status}",
                          textStyle:
                              textStyleSmall()?.copyWith(color: colorPrimary),
                        ))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeH10,
          ),
        ],
      ),
    );
  }

  // ButtonStyle getWidgetByStatus({required String orderStatue}){
  //   if (orderStatue == LocalConstance.orderCancelled) {
  //     return primaryButtonStyle!;
  //   } else if(orderStatue == LocalConstance.orderToDeliver) {
  //     return primaryButtonOpacityStyle!;
  //   }
  //   return buttonStyleBackgroundClicable.copyWith(backgroundColor: MaterialStateProperty.all(colorGreen.withOpacity(0.5)),);
  // }
}
