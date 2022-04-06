import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_three_widgets/payment_item.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../../util/app_shaerd_data.dart';

class ApplicationPayment extends StatelessWidget {
  const ApplicationPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.all(padding7!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(padding6!),
          color: colorBackground),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: sizeH12,
          ),
          Text(tr.choose_payment_method),
          SizedBox(
            height: sizeH12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PaymentItem(
                paymentMethod: PaymentMethod(id: "Wallet", name: "Wallet"),
                isFromApplicationPayment: true,
              ),
              PaymentItem(
                paymentMethod: PaymentMethod(id: "Bank Card", name: "Bank Card"),
                isFromApplicationPayment: true,
              )
            ],
          ),
          SizedBox(
            height: sizeH12,
          ),
        ],
      ),
    );
  }
}
