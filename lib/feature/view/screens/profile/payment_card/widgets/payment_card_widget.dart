import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: padding16!),
          decoration: BoxDecoration(
              color: colorPrimaryOpcaityColor,
              borderRadius: BorderRadius.circular(padding6!)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizeH22,
              ),
              Text(
                tr.name,
                style: textStyleCardPaymentTitle(),
              ),
              Text("Mahnaz Farzin", style: textStyleCardPaymentBody()),
              SizedBox(
                height: sizeH16,
              ),
              Text(
                tr.card_number,
                style: textStyleCardPaymentTitle(),
              ),
              Text("1234 ********** 8901", style: textStyleCardPaymentBody()),
              SizedBox(
                height: sizeH16,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        tr.expiry_date,
                        style: textStyleCardPaymentTitle(),
                      ),
                      Text("03/19", style: textStyleCardPaymentBody())
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        "CVV",
                        style: textStyleCardPaymentTitle(),
                      ),
                      Text("012", style: textStyleCardPaymentBody())
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: sizeH22,
              ),
            ],
          ),
        ),
        PositionedDirectional(
            end: padding16,
            top: padding16,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/svgs/delete_white.svg"),
            ))
      ],
    );
  }
}
