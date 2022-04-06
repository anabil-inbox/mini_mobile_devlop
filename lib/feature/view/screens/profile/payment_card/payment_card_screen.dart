import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/screens/profile/payment_card/widgets/payment_card_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class PaymentCardScreen extends StatelessWidget {
  const PaymentCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          tr.payment_card,
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: sizeH10,
                ),
                PaymentCardWidget(),
                SizedBox(
                  height: sizeH10,
                ),
                PaymentCardWidget(),
                SizedBox(
                  height: sizeH10,
                ),
                PaymentCardWidget(),
                SizedBox(
                  height: sizeH10,
                ),
              ],
            ),
            PositionedDirectional(
              bottom: padding32,
              start: padding20,
              end: padding20,
              child: PrimaryButton(
              isExpanded: true,
              isLoading: false,
              textButton: tr.add_new_card,
              onClicked: () {},
            ))
          ],
        ),
      ),
    );
  }
}
