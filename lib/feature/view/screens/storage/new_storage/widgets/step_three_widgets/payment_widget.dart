import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_item.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({
    Key? key,
    required this.isRecivedOrderPayment,
    this.homeViewModel,
  }) : super(key: key);

  final bool isRecivedOrderPayment;
  final HomeViewModel? homeViewModel;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: padding16!),
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH16,
          ),
          Text("${tr.select_payment_method}"),
          SizedBox(
            height: sizeH16,
          ),
          // Container(
          //   height: sizeH38,
          //   child: ListView(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     children: getPaymentMethod().map((e) {
          //       return PaymentItem(
          //         isRecivedOrderPayment: isRecivedOrderPayment,
          //         paymentMethod: e,
          //       );
          //     }).toList(),
          //   ),
          // ),
          Container(
            // height: sizeH38,
            child: Wrap(
              // shrinkWrap: true,
              // scrollDirection: Axis.horizontal,
              spacing: 10,
              runSpacing: 5,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: getPaymentMethod().map((e) {
                return PaymentItem(
                  isDisable: homeViewModel?.operationTask.totalDue != null &&
                          homeViewModel?.operationTask.totalDue == 0
                      ? true
                      : false,
                  isRecivedOrderPayment: isRecivedOrderPayment,
                  paymentMethod: e,
                  isFirstPickUp: false, isApple: false, isGoggle: false,
                );
              }).toList(),
            ),
          ),
          if (Platform.isIOS) ...[
            SizedBox(
              height: sizeH16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.17,
              child: PaymentItem(
                isFirstPickUp: false,
                isApple:true,
                isRecivedOrderPayment: isRecivedOrderPayment,
                isDisable: homeViewModel?.operationTask.totalDue != null && homeViewModel?.operationTask.totalDue == 0 ? true : false,
                paymentMethod: PaymentMethod(
                    id: LocalConstance.applePay,
                    name: LocalConstance.applePay,
                    image: Constance.appleImage), isGoggle: false,
              ),
            ),

          ],
        // if (Platform.isAndroid) ...[
        //     SizedBox(
        //       height: sizeH16,
        //     ),
        //     SizedBox(
        //       width: MediaQuery.of(context).size.width / 1.17,
        //       child: PaymentItem(
        //         isFirstPickUp: false,
        //         isApple:true,
        //         isGoggle:true,
        //         isRecivedOrderPayment: isRecivedOrderPayment,
        //         isDisable: homeViewModel?.operationTask.totalDue != null && homeViewModel?.operationTask.totalDue == 0 ? true : false,
        //         paymentMethod: PaymentMethod(
        //             id: LocalConstance.googlePay,
        //             name: LocalConstance.googlePay,
        //             image: Constance.googleImage),
        //       ),
        //     ),
        //
        //   ],
          SizedBox(
            height: sizeH25,
          ),
        ],
      ),
    );
  }
}
