import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

import '../order_details_screen.dart';

class MyOrderItem extends StatelessWidget {
  const MyOrderItem({Key? key, required this.orderSales}) : super(key: key);

  final OrderSales orderSales;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);

    return InkWell(
      splashColor: colorTrans,
      highlightColor: colorTrans,
      onTap: () {
        Logger().w(orderSales.toJson());
        Get.to(() => OrderDetailesScreen(orderId: orderSales.orderId ?? "", isFromPayment: false,));
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
                SvgPicture.asset("assets/svgs/folder_seconder.svg"/* desable_box*/ /*, width: sizeW40*/,),
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
                      "${orderSales.proccessName}",
                      // "${orderSales.orderShippingAddress.toString().isNotEmpty ?orderSales.orderShippingAddress : orderSales.orderWarehouseAddress ?? ""}",
                      style: textStyleHints()!.copyWith(fontSize: fontSize13),
                    ),
                    SizedBox(
                      height: sizeH4,
                    ),
                    Text(
                        "${orderSales.deliveryDate.toString().split(" ")[0]}",
                        style: textStyleHints()!.copyWith(fontSize: fontSize13)),
                  ],
                ),
                const Spacer(),
                FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: sizeH10,
                      ),
                      CustomTextView(
                        txt: "${getPriceWithFormate(price: orderSales.totalPrice ?? 0)} ",
                        textStyle: textStylePrimarySmall(),
                      ),
                      SizedBox(
                        height: sizeH6,
                      ),
                      TextButton(
                          clipBehavior: Clip.none,
                          style: orderSales.status == LocalConstance.orderDraft || orderSales.status == LocalConstance.processing
                              ? buttonStyleBackgroundClicable
                              : orderSales.status == LocalConstance.cancelled ? buttonStyleBackgroundGreen.copyWith(backgroundColor:MaterialStateProperty.all(errorColor.withOpacity(0.1))) : buttonStyleBackgroundGreen,
                          onPressed: () {},
                          child: CustomTextView(
                            txt: "${orderSales.statusName}",
                            textStyle: orderSales.status == LocalConstance.orderDraft || orderSales.status == LocalConstance.processing
                                ? textStyleSmall()?.copyWith(color: colorPrimary)
                                : orderSales.status == LocalConstance.cancelled ? textStyleSmall()?.copyWith(color: errorColor): textStyleSmall()?.copyWith(color: colorGreen),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: sizeW10,
                )
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
