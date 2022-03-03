import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/payment.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:inbox_clients/util/sh_util.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem(
      {Key? key,
      required this.paymentMethod,
      this.isFromApplicationPayment = false})
      : super(key: key);

  final PaymentMethod paymentMethod;
  final bool isFromApplicationPayment;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {},
      builder: (builder) {
        return InkWell(
          onTap: () {
            builder.selectedPaymentMethod = paymentMethod;
            builder.update();
            if (isFromApplicationPayment) {
              if (paymentMethod.id == LocalConstance.bankCard) {
                builder.payApplicationFromPaymentGatewaye(
                  price: num.tryParse(SharedPref.instance
                          .getCurrentTaskResponse()
                          ?.totalDue) ??
                      0,
                );
              } else if (paymentMethod.id == LocalConstance.wallet) {
                builder.payApplicationFromWallet(
                    price: num.tryParse(SharedPref.instance
                            .getCurrentTaskResponse()
                            ?.totalDue) ??
                        0,
                    newSalesOrderId: SharedPref.instance
                            .getCurrentTaskResponse()
                            ?.childOrder
                            ?.id ??
                        "");
              }
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: padding4!),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(padding6!),
                border: Border.all(
                    width: 0.5,
                    color: builder.selectedPaymentMethod?.id != paymentMethod.id
                        ? colorBorderContainer
                        : colorTrans),
                color: builder.selectedPaymentMethod?.id != paymentMethod.id
                    ? colorTextWhite
                    : colorPrimary),
            padding: EdgeInsets.symmetric(
                vertical: padding9!, horizontal: padding14!),
            child: Row(
              children: [
                if (paymentMethod.id == LocalConstance.bankCard)
                  SvgPicture.asset(
                    "assets/svgs/bank_card_icon.svg",
                    color: builder.selectedPaymentMethod?.id == paymentMethod.id
                        ? colorBackground
                        : colorHint,
                  ),
                if (paymentMethod.id == LocalConstance.cash)
                  SvgPicture.asset(
                    "assets/svgs/cash_icon.svg",
                    color: builder.selectedPaymentMethod?.id == paymentMethod.id
                        ? colorBackground
                        : colorHint,
                  ),
                if (paymentMethod.id == LocalConstance.wallet)
                  SvgPicture.asset(
                    "assets/svgs/wallet_icon.svg",
                    color: builder.selectedPaymentMethod?.id == paymentMethod.id
                        ? colorBackground
                        : colorHint,
                  ),
                SizedBox(
                  width: sizeW5,
                ),
                CustomTextView(
                  txt: "${paymentMethod.name}",
                  textStyle: builder.selectedPaymentMethod?.id ==
                          paymentMethod.id
                      ? textStylebodyWhite()
                      : textStyleHints()!
                          .copyWith(fontSize: fontSize14, color: colorHint2),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
