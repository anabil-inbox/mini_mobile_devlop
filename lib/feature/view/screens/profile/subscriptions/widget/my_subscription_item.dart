import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';


class MySubscriptionsItem extends StatelessWidget {
  const MySubscriptionsItem({Key? key, /*required this.orderSales*/}) : super(key: key);

  // final OrderSales orderSales;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: colorTrans,
      highlightColor: colorTrans,
      onTap: () {
        //Get.to(() => OrderDetailesScreen(orderId: orderSales.orderId ?? "", isFromPayment: false,));
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
                      "{orderSales.orderId}",
                      style: textStyleMeduimBlackText(),
                    ),
                    SizedBox(
                      height: sizeH4,
                    ),
                    Text(
                      "orderShippingAddress",//{orderSales.orderShippingAddress ?? orderSales.orderWarehouseAddress ?? ""}
                      maxLines: Constance.maxLineOne,
                      style: textStyleHints()!.copyWith(fontSize: fontSize13),
                    ),
                    SizedBox(
                      height: sizeH4,
                    ),
                    Text(
                        "deliveryDate",//{orderSales.deliveryDate.toString().split(" ")[0]}
                        style: textStyleHints()!.copyWith(fontSize: fontSize13)),
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
                    CustomTextView(
                      txt: "Price",//{getPriceWithFormate(price: orderSales.totalPrice ?? 0)}
                      textStyle: textStylePrimarySmall(),
                    ),
                    SizedBox(
                      height: sizeH6,
                    ),
                    TextButton(
                        clipBehavior: Clip.none,
                        style:/* orderSales.status == LocalConstance.orderDraft
                            ? buttonStyleBackgroundClicable
                            :*/ buttonStyleBackgroundGreen,
                        onPressed: () {},
                        child: CustomTextView(
                          txt: "{orderSales.status}",
                          textStyle:/* orderSales.status ==
                                  LocalConstance.orderDraft
                              ? textStyleSmall()?.copyWith(color: colorPrimary)
                              :*/ textStyleSmall()?.copyWith(color: colorGreen),
                        )),
                  ],
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
