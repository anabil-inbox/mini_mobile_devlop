import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/subscription_data.dart';
import 'package:inbox_clients/feature/view/screens/profile/subscriptions_details/subscriptions_details_view.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../../../../../../util/app_shaerd_data.dart';


class MySubscriptionsItem extends StatelessWidget {
  const MySubscriptionsItem({Key? key, this.subscriptions, }) : super(key: key);

   final SubscriptionData? subscriptions;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return InkWell(
      splashColor: colorTrans,
      highlightColor: colorTrans,
      onTap: () {
        Get.to(() => SubscriptionsDetailsView(subscriptions:subscriptions));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // height: sizeH90,
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
                      "${subscriptions?.id}",
                      style: textStyleMeduimBlackText(),
                    ),
                    SizedBox(
                      height: sizeH4,
                    ),
                    // Text(
                    //   "${subscriptions?.a}",//{orderSales.orderShippingAddress ?? orderSales.orderWarehouseAddress ?? ""}
                    //   maxLines: Constance.maxLineOne,
                    //   style: textStyleHints()!.copyWith(fontSize: fontSize13),
                    // ),
                    // SizedBox(
                    //   height: sizeH4,
                    // ),
                    Text("${DateUtility.dateFormatNamed(date: subscriptions?.endDate).toString()}",//{orderSales.deliveryDate.toString().split(" ")[0]}
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
                    // CustomTextView(
                    //   txt: "${subscriptions?.status}",//{getPriceWithFormate(price: orderSales.totalPrice ?? 0)}
                    //   textStyle: textStylePrimarySmall(),
                    // ),
                    // SizedBox(
                    //   height: sizeH6,
                    // ),
                    TextButton(
                        clipBehavior: Clip.none,
                        style: subscriptions?.status != LocalConstance.subscriptionActive
                            ? buttonStyleBackgroundClicable
                            : buttonStyleBackgroundGreen,
                        onPressed: () {},
                        child: CustomTextView(
                          txt: "${subscriptions?.status}",
                          textStyle: subscriptions?.status != LocalConstance.subscriptionActive
                              ? textStyleSmall()?.copyWith(color: colorPrimary)
                              : textStyleSmall()?.copyWith(color: colorGreen),
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
