import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/model/profile/cards_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({Key? key,required this.card}) : super(key: key);
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: sizeH12!),
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
              Text(card.name.toString(), style: textStyleCardPaymentBody()),
              SizedBox(
                height: sizeH16,
              ),
              Text(
                tr.card_number,
                style: textStyleCardPaymentTitle(),
              ),
              Text("${card.firstSix.toString()} ********** ${card.lastFour.toString()}", style: textStyleCardPaymentBody()),
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
                      Text("${card.expMonth.toString()}/${card.expYear.toString()}", style: textStyleCardPaymentBody())
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        "",
                        style: textStyleCardPaymentTitle(),
                      ),
                      Text("${card.brand.toString()}", style: textStyleCardPaymentBody())
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
        // PositionedDirectional(
        //     end: padding16,
        //     top: padding16,
        //     child: IconButton(
        //       onPressed: () {},
        //       icon: SvgPicture.asset("assets/svgs/delete_white.svg"),
        //     ))
      ],
    );
  }
}
