import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_item.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({Key? key , required this.isRecivedOrderPayment}) : super(key: key);

  final bool isRecivedOrderPayment;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
          SizedBox(
            height: sizeH16,
          ),
          Text("${tr.select_payment_method}"),
          SizedBox(
            height: sizeH16,
          ),
          Container(
            height: sizeH38,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: getPaymentMethod().map((e) {
                return PaymentItem(
                  isRecivedOrderPayment: isRecivedOrderPayment,
                  paymentMethod: e,
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: sizeH25,
          ),
        ],
      ),
    );
  }
}
