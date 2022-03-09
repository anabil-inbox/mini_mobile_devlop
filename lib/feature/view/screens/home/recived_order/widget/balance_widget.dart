import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/sh_util.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CustomTextView(
            txt: tr.boxes,
            textStyle: textStyleNormal()?.copyWith(color: colorBlack),
          ),
          SizedBox(height: sizeH13),
          Row(
            children: [
              CustomTextView(
                txt: tr.total,
                textStyle: textStyleNormal(),
              ),
              const Spacer(),
              CustomTextView(
                txt: getPriceWithFormate(
                    price:
                     num.parse(
                        SharedPref.instance.getCurrentTaskResponse()?.total.toString() ??
                            "0")),
                textStyle: textStyleMeduimPrimaryBold(),
              ),
            ],
          ),
          SizedBox(height: sizeH14),
          Row(
            children: [
              CustomTextView(
                txt: tr.paid,
                textStyle: textStyleNormal(),
              ),
              const Spacer(),
              CustomTextView(
                txt: getPriceWithFormate(
                    price: num.parse(
                        SharedPref.instance.getCurrentTaskResponse()?.totalPaid.toString() ??
                            "0")),
                textStyle: textStyleMeduimPrimaryBold(),
              ),
            ],
          ),
          SizedBox(height: sizeH14),
          Row(
            children: [
              CustomTextView(
                txt: tr.amount_due,
                textStyle: textStyleNormal(),
              ),
              const Spacer(),
              CustomTextView(
                txt: getPriceWithFormate(
                    price: num.parse(
                        SharedPref.instance.getCurrentTaskResponse()?.totalDue.toString() ??
                            "0")),
                textStyle: textStyleMeduimPrimaryBold(),
              ),
            ],
          ),
          SizedBox(height: sizeH22),
          // const PaymentWidget(),
        ],
      ),
    );
  }
}
